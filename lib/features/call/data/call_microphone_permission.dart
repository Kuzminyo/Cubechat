import 'package:permission_handler/permission_handler.dart';
import '../../../core/util/debug_log.dart';

/// Ask for the microphone at launch, before any call needs it.
///
/// "The permissions should just be there, not something to go and turn on"
/// was the report. The microphone is the one a call cannot do without that an
/// app is allowed to ask for with a plain system dialog - and the one moment it
/// cannot be asked is the one that matters most: a call answered from the lock
/// screen or the shade has no screen of the app's to put a dialog on, so it
/// would connect with nobody hearing a word. Only while the system would still
/// show the dialog; a refusal is final, and the next call asks again in the
/// app as before.
Future<void> askCallMicrophoneAhead({
  Future<PermissionStatus> Function()? check,
  Future<PermissionStatus> Function()? request,
}) async {
  try {
    final status = await (check ?? () => Permission.microphone.status)();
    if (!status.isDenied) return;
    final after = await (request ?? () => Permission.microphone.request())();
    DebugLog.instance.log('CALL', 'microphone asked at launch: ${after.name}');
  } catch (e) {
    DebugLog.instance.log('CALL', 'microphone could not be asked at launch: $e');
  }
}

/// Read system permission for every attempt, including after returning from
/// Settings. The iOS pod must compile PERMISSION_MICROPHONE=1.
Future<bool> requestCallMicrophonePermission({
  Future<PermissionStatus> Function()? check,
  Future<PermissionStatus> Function()? request,
}) async {
  final before = await (check ?? () => Permission.microphone.status)();
  DebugLog.instance.log('CALL', 'microphone permission before: ${before.name}');
  if (before.isGranted) return true;
  final after = await (request ?? () => Permission.microphone.request())();
  DebugLog.instance.log('CALL', 'microphone permission after: ${after.name}');
  return after.isGranted;
}

/// The camera, for a video call. [ask] false only reads the answer already
/// given: answered from the lock screen there is no screen to put a dialog
/// on, and a request there can wait for ever. The camera button asks again
/// once the app is open. The iOS pod compiles PERMISSION_CAMERA=1 already.
Future<bool> requestCallCameraPermission({
  required bool ask,
  Future<PermissionStatus> Function()? check,
  Future<PermissionStatus> Function()? request,
}) async {
  final before = await (check ?? () => Permission.camera.status)();
  DebugLog.instance.log('CALL', 'camera permission before: ${before.name}');
  if (before.isGranted) return true;
  if (!ask) return false;
  final after = await (request ?? () => Permission.camera.request())();
  DebugLog.instance.log('CALL', 'camera permission after: ${after.name}');
  return after.isGranted;
}
