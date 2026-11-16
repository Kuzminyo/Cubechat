import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Which way the dependencies point.
///
/// `lib/core/` is the transport, the crypto, BLE, storage and the shared
/// widgets; `lib/features/` builds on it; `lib/app/` is where the two are
/// wired together (`bindings.dart`, the router, the wipe). Core importing a
/// feature means core cannot be built, read or tested without it — which is
/// how `MessagingService` came to reach forty controllers. See
/// docs/superpowers/specs/2026-11-16-messaging-service-split-design.md.
///
/// [_featureImportsAllowed] is a ratchet: what is left today, file by file.
/// A number may go down — lower it here in the same change — and may never go
/// up. A file not listed may import no feature at all.
const _featureImportsAllowed = <String, int>{
  // The send paths and the payloads the transport still answers itself
  // (room posts and administration, media, presence, avatars) read feature
  // controllers directly. Each one moved behind a port or into a module
  // takes its import with it.
  'lib/core/transport/messaging_service.dart': 27,
};

final _featureImport = RegExp(
  r"""^\s*(?:import|export)\s+'(?:(?:\.\./)+|package:cubechat/)features/""",
  multiLine: true,
);

final _appImport = RegExp(
  r"""^\s*(?:import|export)\s+'(?:(?:\.\./)+|package:cubechat/)app(?:/|\.dart')""",
  multiLine: true,
);

Iterable<File> _dartFiles(String root) => Directory(root)
    .listSync(recursive: true)
    .whereType<File>()
    .where((f) => f.path.endsWith('.dart'));

String _rel(File f) => f.path.replaceAll(r'\', '/');

void main() {
  test('core imports no feature beyond what the ratchet allows', () {
    final over = <String>[];
    for (final file in _dartFiles('lib/core')) {
      final path = _rel(file);
      final count = _featureImport.allMatches(file.readAsStringSync()).length;
      final allowed = _featureImportsAllowed[path] ?? 0;
      if (count > allowed) over.add('$path: $count (allowed $allowed)');
    }
    expect(over, isEmpty);
  });

  test('the ratchet is tight', () {
    // A number left above what the file now imports would let the next
    // change add imports back without anybody noticing.
    for (final entry in _featureImportsAllowed.entries) {
      final file = File(entry.key);
      expect(file.existsSync(), isTrue, reason: '${entry.key} moved');
      final count = _featureImport.allMatches(file.readAsStringSync()).length;
      expect(
        count,
        entry.value,
        reason: '${entry.key} imports $count features now; '
            'set its allowance to $count',
      );
    }
  });

  test('core never imports the app layer', () {
    final offenders = [
      for (final file in _dartFiles('lib/core'))
        if (_appImport.hasMatch(file.readAsStringSync())) _rel(file),
    ];
    expect(offenders, isEmpty);
  });
}
