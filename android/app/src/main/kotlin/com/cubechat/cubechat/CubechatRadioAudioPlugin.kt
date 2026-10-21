package com.cubechat.cubechat

import android.content.Context
import android.media.AudioAttributes
import android.media.AudioDeviceInfo
import android.media.AudioFocusRequest
import android.media.AudioFormat
import android.media.AudioManager
import android.media.AudioTrack
import android.os.Build
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import java.util.concurrent.atomic.AtomicInteger

/**
 * Plays walkie-talkie audio as it arrives: raw PCM16 mono pushed into a
 * streaming [AudioTrack].
 *
 * Dart decodes the Opus chunks (`radio_audio.dart` is the other half) and hands
 * over 300 ms of samples at a time. A file or a `MediaPlayer` has no way to
 * take audio that has not finished arriving, which is why this is a track in
 * MODE_STREAM and not another use of the audio players the voice notes use.
 *
 * Everything that touches the track runs on one background thread. A blocking
 * write against a full track would otherwise sit on the platform thread, and
 * that thread is also where every other channel in the app is answered. The
 * replies go out at once: Dart does not wait for the speaker, it only needs to
 * know the request was taken.
 *
 * A [FlutterPlugin] so it can be added to the engine with `plugins.add`, like
 * the pubspec ones. It is added in [MainApplication] with the other custom
 * channels, not in the Activity: the engine outlives the Activity, and a radio
 * message must be able to play with the app swiped away and the screen off,
 * when no Activity has been created to register anything.
 */
class CubechatRadioAudioPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {

    private var channel: MethodChannel? = null
    private var appContext: Context? = null
    private var worker: ExecutorService? = null

    /**
     * Bumped by every start and stop, on the platform thread, and read by the
     * worker. A write queued before a stop must not be heard after it, and a
     * write stuck waiting for room in the track must notice the stop and give
     * up — see [writeAll].
     */
    @Volatile
    private var generation = 0

    /**
     * PCM bytes accepted but not yet handed to the track. Radio chunks arrive
     * at the rate they play, so this stays near one chunk; it only grows if the
     * track stops draining (another app holding the output, a stalled HAL).
     * Past [MAX_PENDING_BYTES] new audio is dropped: a walkie-talkie that is
     * two seconds behind is no longer a walkie-talkie, and the queue must not
     * grow for as long as the other side keeps talking.
     */
    private val pendingBytes = AtomicInteger(0)

    // Worker thread only from here down.
    private var track: AudioTrack? = null
    private var focusRequest: AudioFocusRequest? = null
    private var legacyFocusListener: AudioManager.OnAudioFocusChangeListener? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        appContext = binding.applicationContext
        worker = Executors.newSingleThreadExecutor { r -> Thread(r, "cubechat-radio-audio") }
        channel = MethodChannel(binding.binaryMessenger, CHANNEL).also {
            it.setMethodCallHandler(this)
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel?.setMethodCallHandler(null)
        channel = null
        generation++
        // Queued work still runs after shutdown(); the release goes in last.
        worker?.execute { release() }
        worker?.shutdown()
        worker = null
        appContext = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val exec = worker
        if (exec == null) {
            result.success(null)
            return
        }
        when (call.method) {
            "start" -> {
                // "inCall" is not read here: Android has no shared session to
                // keep its hands off, and the radio does not play during a
                // call anyway (the controller drops chunks while one is up).
                val sampleRate = call.argument<Int>("sampleRate") ?: SAMPLE_RATE
                val silentOk = call.argument<Boolean>("playInSilentMode") ?: false
                val gen = ++generation
                exec.execute { start(sampleRate, silentOk, gen) }
                result.success(null)
            }
            "write" -> {
                val bytes = call.arguments as? ByteArray
                if (bytes != null && bytes.size >= 2) {
                    val size = bytes.size
                    if (pendingBytes.addAndGet(size) > MAX_PENDING_BYTES) {
                        pendingBytes.addAndGet(-size)
                    } else {
                        val gen = generation
                        exec.execute {
                            try {
                                write(bytes, gen)
                            } finally {
                                pendingBytes.addAndGet(-size)
                            }
                        }
                    }
                }
                result.success(null)
            }
            "stop" -> {
                generation++
                exec.execute { release() }
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    private fun start(sampleRate: Int, playInSilentMode: Boolean, gen: Int) {
        // "Start twice restarts cleanly": whatever the first start built goes
        // before the second is made, so there is never a second track on the
        // speaker.
        release()
        if (gen != generation) return // stopped again before we got here
        val ctx = appContext ?: return
        try {
            // USAGE_ALARM is the one usage the ringer switch does not mute on
            // Android; USAGE_MEDIA follows the media volume and is silenced
            // with it. The content is speech either way, which is what lets
            // the system treat it as a voice and not as music.
            //
            // But an alarm is also played out of the loudspeaker when earbuds
            // or a headset are in - the policy makes sure an alarm is heard
            // even if the headphones are lying on the table - and a private
            // 1:1 message would then be read out to the room. With something
            // on the user's ears there is no silent switch to get past anyway:
            // media goes to the earbuds and only there. Checked per start, and
            // the controller starts once per transmission, so plugging in
            // earbuds takes effect from the next one.
            val alarm = playInSilentMode && !privateOutputPresent(ctx)
            val attrs = AudioAttributes.Builder()
                .setUsage(
                    if (alarm) {
                        AudioAttributes.USAGE_ALARM
                    } else {
                        AudioAttributes.USAGE_MEDIA
                    },
                )
                .setContentType(AudioAttributes.CONTENT_TYPE_SPEECH)
                .build()
            val format = AudioFormat.Builder()
                .setEncoding(AudioFormat.ENCODING_PCM_16BIT)
                .setSampleRate(sampleRate)
                .setChannelMask(AudioFormat.CHANNEL_OUT_MONO)
                .build()
            val minBuffer = AudioTrack.getMinBufferSize(
                sampleRate,
                AudioFormat.CHANNEL_OUT_MONO,
                AudioFormat.ENCODING_PCM_16BIT,
            )
            if (minBuffer <= 0) {
                Log.e(TAG, "no buffer size for $sampleRate Hz mono ($minBuffer)")
                return
            }
            // Four times the minimum: the minimum is the smallest the mixer
            // can run without underrunning on an idle phone, and a chunk that
            // arrives a few milliseconds late on a busy one is the normal case
            // for audio that came over Bluetooth.
            val created = AudioTrack.Builder()
                .setAudioAttributes(attrs)
                .setAudioFormat(format)
                .setBufferSizeInBytes(minBuffer * BUFFER_FACTOR)
                .setTransferMode(AudioTrack.MODE_STREAM)
                .build()
            if (created.state != AudioTrack.STATE_INITIALIZED) {
                Log.e(TAG, "AudioTrack did not initialise")
                created.release()
                return
            }
            requestFocus(ctx, attrs, alarm)
            created.play()
            track = created
        } catch (e: Throwable) {
            // No speaker is a lost message, never a crash on the worker.
            Log.e(TAG, "start failed", e)
            release()
        }
    }

    /**
     * Whether a wired headset or headphones, a USB headset, Bluetooth audio
     * (A2DP, SCO, LE audio) or a hearing aid is connected as an output - one
     * that USAGE_ALARM would duplicate to the loudspeaker. Types newer than
     * minSdk 24 are only asked for where the OS has them.
     */
    private fun privateOutputPresent(ctx: Context): Boolean {
        val am = ctx.getSystemService(Context.AUDIO_SERVICE) as? AudioManager ?: return false
        val types = mutableSetOf(
            AudioDeviceInfo.TYPE_WIRED_HEADSET,
            AudioDeviceInfo.TYPE_WIRED_HEADPHONES,
            AudioDeviceInfo.TYPE_BLUETOOTH_A2DP,
            AudioDeviceInfo.TYPE_BLUETOOTH_SCO,
        )
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            types.add(AudioDeviceInfo.TYPE_USB_HEADSET)
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            types.add(AudioDeviceInfo.TYPE_HEARING_AID)
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            types.add(AudioDeviceInfo.TYPE_BLE_HEADSET)
            types.add(AudioDeviceInfo.TYPE_BLE_SPEAKER)
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            types.add(AudioDeviceInfo.TYPE_BLE_BROADCAST)
        }
        return try {
            am.getDevices(AudioManager.GET_DEVICES_OUTPUTS).any { it.type in types }
        } catch (e: Throwable) {
            Log.e(TAG, "output devices unreadable", e)
            false
        }
    }

    private fun requestFocus(ctx: Context, attrs: AudioAttributes, alarm: Boolean) {
        val am = ctx.getSystemService(Context.AUDIO_SERVICE) as? AudioManager ?: return
        // MAY_DUCK: music is turned down under a walkie-talkie message, not
        // paused. The listener is empty on purpose — the system applies the
        // ducking to others for us, and a message is too short to stop for.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val request = AudioFocusRequest.Builder(AudioManager.AUDIOFOCUS_GAIN_TRANSIENT_MAY_DUCK)
                .setAudioAttributes(attrs)
                .setOnAudioFocusChangeListener { }
                .build()
            am.requestAudioFocus(request)
            focusRequest = request
        } else {
            val listener = AudioManager.OnAudioFocusChangeListener { }
            @Suppress("DEPRECATION")
            am.requestAudioFocus(
                listener,
                if (alarm) AudioManager.STREAM_ALARM else AudioManager.STREAM_MUSIC,
                AudioManager.AUDIOFOCUS_GAIN_TRANSIENT_MAY_DUCK,
            )
            legacyFocusListener = listener
        }
    }

    private fun write(bytes: ByteArray, gen: Int) {
        val t = track ?: return // write before start: nothing to play into
        if (gen != generation) return
        // A short trailing byte would be half a sample.
        writeAll(t, bytes, bytes.size and 1.inv(), gen)
    }

    /**
     * Pushes [size] bytes into [t] without ever blocking on a full track.
     *
     * A blocking write holds this thread until the speaker has made room, and
     * if the speaker is not draining that is forever — the stop queued behind
     * it would never run, and the radio could not be restarted. Non-blocking
     * writes return how much fitted; the remainder waits five milliseconds and
     * checks [generation] each time round, so a stop ends the wait at once.
     */
    private fun writeAll(t: AudioTrack, bytes: ByteArray, size: Int, gen: Int) {
        var offset = 0
        while (offset < size) {
            if (gen != generation) return
            val n = t.write(bytes, offset, size - offset, AudioTrack.WRITE_NON_BLOCKING)
            if (n < 0) {
                // ERROR_DEAD_OBJECT and friends: the output went away (headset
                // pulled, audio server restarted). Drop this track; the next
                // start builds a new one.
                Log.e(TAG, "AudioTrack.write failed: $n")
                release()
                return
            }
            if (n == 0) {
                try {
                    Thread.sleep(WAIT_FOR_ROOM_MS)
                } catch (_: InterruptedException) {
                    return
                }
            } else {
                offset += n
            }
        }
    }

    /**
     * Pause, flush, release — not `stop()`. In stream mode `stop()` plays out
     * everything already queued, and a stop here means the controller has
     * decided the audio is over: the 300 ms still in the buffer belongs to a
     * message that was cut or has ended.
     */
    private fun release() {
        val t = track
        track = null
        if (t != null) {
            try {
                t.pause()
                t.flush()
            } catch (_: Throwable) {
            }
            try {
                t.release()
            } catch (_: Throwable) {
            }
        }
        val ctx = appContext
        val am = ctx?.getSystemService(Context.AUDIO_SERVICE) as? AudioManager
        if (am != null) {
            try {
                val request = focusRequest
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O && request != null) {
                    am.abandonAudioFocusRequest(request)
                }
                val listener = legacyFocusListener
                if (listener != null) {
                    @Suppress("DEPRECATION")
                    am.abandonAudioFocus(listener)
                }
            } catch (_: Throwable) {
            }
        }
        focusRequest = null
        legacyFocusListener = null
    }

    companion object {
        const val CHANNEL = "cubechat/radio_audio"
        private const val TAG = "RadioAudio"
        private const val SAMPLE_RATE = 48000
        private const val BUFFER_FACTOR = 4
        private const val WAIT_FOR_ROOM_MS = 5L

        /** Two seconds of 48 kHz mono PCM16. */
        private const val MAX_PENDING_BYTES = SAMPLE_RATE * 2 * 2
    }
}
