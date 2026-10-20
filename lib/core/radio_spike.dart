import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'util/debug_log.dart';

/// Stage-0 spike of the walkie-talkie: a throwaway on branch spike/ios-ptt.
///
/// One question, asked on a real iPhone: when a message arrives over Bluetooth
/// with no internet while the phone is locked, can the app make the system's
/// PushToTalk channel activate audio and play a sound
/// (`setActiveRemoteParticipant` -> `channelManager(_:didActivate:)`)?
///
/// The native half is `CubechatRadioSpike` at the end of AppDelegate.swift. It
/// answers every call with a string and also reports every delegate callback
/// back over this channel as `log`, which lands in Diagnostics under
/// `[RADIO-SPIKE]`. The marker text [marker], sent from an Android phone as an
/// ordinary chat message, is what drives [incoming].
class RadioSpike {
  RadioSpike._() {
    _channel.setMethodCallHandler(_fromNative);
  }

  static final RadioSpike instance = RadioSpike._();

  static const tag = 'RADIO-SPIKE';

  /// What the sender pastes into a chat. Compared with `startsWith`.
  static const marker = 'cubechat:radiospike:v1';

  static const _channel = MethodChannel('cubechat/radio_spike');

  Future<dynamic> _fromNative(MethodCall call) async {
    if (call.method == 'log') {
      DebugLog.instance.log(tag, '${call.arguments}');
    }
    return null;
  }

  /// Asks the system to join the fixed test channel.
  Future<String> join() => _invoke('join', null);

  /// Makes [fromName] the active remote participant, which is what should
  /// activate the channel's audio session.
  ///
  /// The name is a peer's own display name, so it is clamped to [maxNameLength]
  /// characters (code points, never mid-pair) before it reaches the system UI.
  Future<String> incoming(String fromName) =>
      _invoke('incoming', clampName(fromName));

  static const maxNameLength = 32;

  @visibleForTesting
  static String clampName(String name) =>
      String.fromCharCodes(name.runes.take(maxNameLength));

  Future<String> leave() => _invoke('leave', null);

  Future<String> _invoke(String method, Object? arguments) async {
    String text;
    try {
      text = await _channel.invokeMethod<String>(method, arguments) ?? 'null';
    } catch (e) {
      text = 'error: $e';
    }
    DebugLog.instance.log(tag, '$method -> $text');
    return text;
  }
}
