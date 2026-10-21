import 'dart:typed_data';

import 'ogg_opus.dart';
import 'opus_format.dart';
export 'opus_format.dart';

/// Where there is no `dart:ffi` — the web build used for interface work —
/// there is no libopus either. Every way in says so, and every caller already
/// has a way round it: the recorder falls back to AAC, and a note that cannot
/// be decoded is handed to the player as it is.
class OpusNoteWriter {
  OpusNoteWriter() {
    throw UnsupportedError('Opus needs dart:ffi');
  }

  Duration get duration => Duration.zero;
  List<double> get levels => const <double>[];
  void Function(double level)? onLevel;
  void add(Uint8List bytes) {}
  OggOpusStream finish() => throw UnsupportedError('Opus needs dart:ffi');
  void discard() {}
}

Future<Uint8List> decodeOggOpusToWav(Uint8List ogg) async =>
    throw UnsupportedError('Opus needs dart:ffi');

/// The walkie-talkie's codec, refused the same way: the radio controller
/// catches it and the radio says it is unavailable here. [library] is
/// `Object?` because `OpusLibrary` is an ffi type the web does not have.
class OpusVoiceEncoder {
  OpusVoiceEncoder({
    Object? library,
    int bitRate = OpusVoice.bitRate,
    bool vbr = true,
  }) {
    throw UnsupportedError('Opus needs dart:ffi');
  }

  Uint8List encode(Int16List frame) =>
      throw UnsupportedError('Opus needs dart:ffi');
  void dispose() {}
}

class OpusVoiceDecoder {
  OpusVoiceDecoder({int channels = OpusVoice.channels, Object? library}) {
    throw UnsupportedError('Opus needs dart:ffi');
  }

  Int16List decode(Uint8List packet) =>
      throw UnsupportedError('Opus needs dart:ffi');
  void dispose() {}
}
