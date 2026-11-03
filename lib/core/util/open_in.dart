import 'dart:io';
import 'dart:ui' show Rect;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

import 'debug_log.dart';
import 'platform_info.dart';

/// Give a file to another app, and go there.
///
/// iOS only, and deliberately not a replacement for the share sheet. The two
/// are different mechanisms with different outcomes:
///
///   * `Share.shareXFiles` presents `UIActivityViewController`, which runs the
///     chosen app's *share extension* — a window belonging to that app, drawn
///     over cubechat. The phone never leaves this app. That is the platform's
///     design and no flag turns it off.
///   * This presents `UIDocumentInteractionController`'s "Open in…" menu, which
///     copies the file into the target app and launches it. The phone changes
///     apps, which is what people mean when they say "send it to Telegram".
///
/// Only apps that declare they handle the file's type appear in that menu, so
/// it can legitimately come up empty — [handOff] answers false and the caller
/// falls back to the sheet rather than leaving a tap that did nothing.
///
/// Android needs none of this: a share intent already resolves to the real app.
class OpenIn {
  const OpenIn._();

  static const MethodChannel channel = MethodChannel('cubechat/open_in');

  /// Whether the platform has a hand-off distinct from the share sheet at all.
  ///
  /// Android does too, and for a different reason than iOS. There the sheet
  /// runs the target's share *extension* over this app; here it launches the
  /// target's activity into cubechat's own task, because share_plus starts it
  /// without FLAG_ACTIVITY_NEW_TASK — so picking Telegram put Telegram inside a
  /// recents card wearing cubechat's icon. MainActivity's handler sets the flag
  /// and the chosen app opens as itself. Both platforms answer the same
  /// question: does the phone actually go to the other app.
  static bool get isSupported => PlatformInfo.isIOS || PlatformInfo.isAndroid;

  /// Offer a line of text — a contact card, a link — to another app.
  ///
  /// Android only. iOS has no document-interaction equivalent for text, and it
  /// does not need one: the share sheet's behaviour there is the platform's
  /// own, while on Android the sheet leaves the chosen app inside cubechat's
  /// task. False means the caller should fall back to the sheet.
  static Future<bool> handOffText(String text, {String? subject}) async {
    if (!PlatformInfo.isAndroid) return false;
    try {
      final shown = await channel.invokeMethod<bool>('openInText', {
        'text': text,
        'subject': subject,
      });
      return shown ?? false;
    } catch (e) {
      DebugLog.instance.log('SHARE', 'text hand-off unavailable: $e');
      return false;
    }
  }

  /// Put a copy of [path] wherever the user picks, through the system's own
  /// "save as" screen — Files on iOS, the document picker on Android — named
  /// [name] unless they rename it.
  ///
  /// Only a path crosses the channel; the platform copies the file itself. A
  /// backup with video in it runs to hundreds of megabytes, and the API this
  /// replaces wanted all of it as bytes in the Dart heap.
  ///
  /// Null when there is no such screen here — an old build, a desktop — so
  /// the caller can fall back to the share sheet.
  static Future<SaveAsOutcome?> saveAs(String path, {required String name}) async {
    if (!isSupported) return null;
    try {
      final answer = await channel.invokeMethod<String>('saveAs', {
        'path': path,
        'name': name,
      });
      return switch (answer) {
        'saved' => SaveAsOutcome.saved,
        'cancelled' => SaveAsOutcome.cancelled,
        _ => SaveAsOutcome.failed,
      };
    } on MissingPluginException {
      return null;
    } catch (e) {
      DebugLog.instance.log('SHARE', 'save-as failed: ${e.runtimeType}');
      return SaveAsOutcome.failed;
    }
  }

  /// Offer [path] to the apps that can open it. Returns whether the menu was
  /// actually shown.
  ///
  /// [anchor] is where the menu points, in logical pixels — the same rect the
  /// share sheet needs, and needed for the same reason: UIKit presents this as
  /// a popover and refuses an empty or off-screen source. Use `shareAnchorFor`
  /// to measure the control that was tapped.
  static Future<bool> handOff(String path, {required Rect anchor}) async {
    if (!isSupported) return false;
    try {
      final shown = await channel.invokeMethod<bool>('openIn', {
        'path': path,
        'anchor': {
          'x': anchor.left,
          'y': anchor.top,
          'width': anchor.width,
          'height': anchor.height,
        },
      });
      return shown ?? false;
    } catch (e) {
      // A build without the plugin registered raises MissingPluginException;
      // everything else arrives as a PlatformException. Neither is worth
      // failing the user's tap over when there is a share sheet behind it.
      DebugLog.instance.log('SHARE', 'open-in unavailable: $e');
      return false;
    }
  }
}

/// How a [OpenIn.saveAs] ended.
enum SaveAsOutcome { saved, cancelled, failed }

/// A folder the user chose once for the automatic backup: [id] is what the
/// platform needs to reach it again — a tree URI on Android, a bookmark on
/// iOS, a plain path on a computer — and [name] is what to show.
typedef BackupFolderRef = ({String id, String name});

/// How writing into a [BackupFolderRef] ended. [denied] means the folder is
/// gone or its permission was taken back: only picking it again helps.
enum FolderWriteOutcome { saved, denied, failed }

/// The automatic backup's way into a folder outside the app.
///
/// On a phone the app cannot keep a path to such a folder — Android hands
/// out a tree URI with a persistable grant, iOS a security-scoped bookmark —
/// so the choice and every later write go through the platform. A computer
/// has plain paths and needs neither.
class BackupFolderAccess {
  const BackupFolderAccess._();

  static bool get _native => PlatformInfo.isIOS || PlatformInfo.isAndroid;

  /// Null when cancelled or unavailable.
  static Future<BackupFolderRef?> pick() async {
    if (!_native) {
      final path = await FilePicker.platform.getDirectoryPath();
      if (path == null || path.isEmpty) return null;
      final parts = path.split(RegExp(r'[\\/]')).where((p) => p.isNotEmpty);
      return (id: path, name: parts.isEmpty ? path : parts.last);
    }
    try {
      final answer =
          await OpenIn.channel.invokeMapMethod<String, Object?>('pickFolder');
      final id = answer?['id'];
      final name = answer?['name'];
      if (id is! String || id.isEmpty) return null;
      return (id: id, name: name is String && name.isNotEmpty ? name : id);
    } catch (e) {
      DebugLog.instance.log('BACKUP', 'folder picker unavailable: $e');
      return null;
    }
  }

  /// Copy [path] into [folder] as [name], replacing the copy there. A renewed
  /// folder id, when the platform issued one, comes back beside the outcome
  /// and should replace the stored one.
  static Future<({FolderWriteOutcome outcome, String? renewedId})> write(
    BackupFolderRef folder, {
    required String name,
    required String path,
  }) async {
    if (!_native) {
      try {
        final dir = Directory(folder.id);
        if (!dir.existsSync()) {
          return (outcome: FolderWriteOutcome.denied, renewedId: null);
        }
        final target = '${dir.path}${Platform.pathSeparator}$name';
        final partial = File('$target.partial');
        await File(path).copy(partial.path);
        await partial.rename(target);
        return (outcome: FolderWriteOutcome.saved, renewedId: null);
      } on FileSystemException {
        return (outcome: FolderWriteOutcome.failed, renewedId: null);
      }
    }
    try {
      final answer = await OpenIn.channel.invokeMethod<Object?>(
        'writeToFolder',
        {'folder': folder.id, 'name': name, 'path': path},
      );
      // Android answers a bare string; iOS a map that can carry a renewed
      // bookmark.
      final map = answer is Map ? answer : null;
      final word = map != null ? map['outcome'] : answer;
      final renewed = map?['id'];
      return (
        outcome: switch (word) {
          'saved' => FolderWriteOutcome.saved,
          'denied' => FolderWriteOutcome.denied,
          _ => FolderWriteOutcome.failed,
        },
        renewedId: renewed is String && renewed.isNotEmpty ? renewed : null,
      );
    } catch (e) {
      DebugLog.instance.log('BACKUP', 'folder write failed: ${e.runtimeType}');
      return (outcome: FolderWriteOutcome.failed, renewedId: null);
    }
  }
}
