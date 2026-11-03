import Flutter
import UIKit
import UniformTypeIdentifiers

/// Hands a file to another app and *switches to it*.
///
/// iOS has two ways to give a file away and they behave nothing alike. The
/// share sheet (`UIActivityViewController`, which is what share_plus presents)
/// runs the chosen app's share extension — a small window belonging to that app
/// drawn on top of ours, which never leaves cubechat. The other is this one:
/// `UIDocumentInteractionController`'s "Open in…" menu copies the file into the
/// target app's inbox and launches it, so the phone actually changes apps.
/// Nothing about the first can be configured into the second; they are separate
/// mechanisms, which is why this exists at all.
///
/// Returns false rather than an error when no installed app claims the file's
/// type — the menu would come up empty, so the Dart side falls back to the
/// share sheet instead of leaving a tap that does nothing.
final class CubechatOpenInPlugin: NSObject, UIDocumentInteractionControllerDelegate,
  UIDocumentPickerDelegate
{
  private let channel: FlutterMethodChannel

  /// Who is waiting on the Files export sheet — see [saveAs].
  private var pendingSave: FlutterResult?

  /// Held for as long as the menu is up. `UIDocumentInteractionController` is
  /// not retained by the presentation, so a local would be deallocated on the
  /// way out of `handle` and the menu would vanish with it.
  private var interaction: UIDocumentInteractionController?

  init(messenger: FlutterBinaryMessenger) {
    channel = FlutterMethodChannel(
      name: "cubechat/open_in",
      binaryMessenger: messenger
    )
    super.init()
    channel.setMethodCallHandler { [weak self] call, result in
      self?.handle(call, result: result)
    }
  }

  private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "saveAs" {
      saveAs(call.arguments as? [String: Any], result: result)
      return
    }
    if call.method == "pickFolder" {
      pickFolder(result: result)
      return
    }
    if call.method == "writeToFolder" {
      writeToFolder(call.arguments as? [String: Any], result: result)
      return
    }
    guard call.method == "openIn" else {
      result(FlutterMethodNotImplemented)
      return
    }
    guard
      let args = call.arguments as? [String: Any],
      let path = args["path"] as? String,
      FileManager.default.fileExists(atPath: path),
      let view = Self.topViewController()?.view
    else {
      result(false)
      return
    }

    let controller = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
    controller.delegate = self
    if let uti = args["uti"] as? String, !uti.isEmpty {
      controller.uti = uti
    }
    interaction = controller

    // Same anchor rule as the share sheet: UIKit presents this as a popover and
    // rejects an empty or off-screen source rect outright. The Dart side
    // measures the control that was tapped (see `shareAnchorFor`); this only
    // clamps it back inside the view it is being presented from, since a rect
    // measured a frame ago can have scrolled away.
    let anchor = Self.rect(from: args["anchor"], within: view.bounds)
    let presented = controller.presentOpenInMenu(from: anchor, in: view, animated: true)
    if !presented {
      interaction = nil
    }
    result(presented)
  }

  private static func rect(from raw: Any?, within bounds: CGRect) -> CGRect {
    guard
      let a = raw as? [String: Any],
      let x = (a["x"] as? NSNumber)?.doubleValue,
      let y = (a["y"] as? NSNumber)?.doubleValue,
      let w = (a["width"] as? NSNumber)?.doubleValue,
      let h = (a["height"] as? NSNumber)?.doubleValue,
      w > 0, h > 0
    else {
      return CGRect(x: bounds.midX, y: bounds.midY, width: 1, height: 1)
    }
    let candidate = CGRect(x: x, y: y, width: w, height: h)
    return bounds.contains(candidate)
      ? candidate
      : CGRect(x: bounds.midX, y: bounds.midY, width: 1, height: 1)
  }

  /// Put a copy of a file in Files — On My iPhone, iCloud Drive, a USB stick.
  ///
  /// The backup reached this through FilePicker.saveFile until the backup
  /// grew its photos and video; that call wants the whole file as bytes, so it
  /// was swapped for the share sheet, and "save it somewhere" quietly became
  /// "send it to an app". The export picker takes a file URL instead and copies
  /// it itself, so nothing about the archive's size touches the Dart heap.
  ///
  /// Answers "saved", "cancelled" or "failed".
  private func saveAs(_ args: [String: Any]?, result: @escaping FlutterResult) {
    guard pendingSave == nil else {
      result(FlutterError(code: "busy", message: "a save is already open", details: nil))
      return
    }
    guard
      let path = args?["path"] as? String,
      FileManager.default.fileExists(atPath: path),
      let top = Self.topViewController()
    else {
      result("failed")
      return
    }
    let picker = UIDocumentPickerViewController(
      forExporting: [URL(fileURLWithPath: path)],
      asCopy: true
    )
    picker.delegate = self
    pendingSave = result
    top.present(picker, animated: true)
  }

  /// Who is waiting on the folder picker — see [pickFolder].
  private var pendingFolder: FlutterResult?

  /// Let the user choose, once, a folder in Files — On My iPhone, iCloud
  /// Drive — that the automatic backup writes to from then on. Kept as a
  /// security-scoped bookmark, the only thing that lets an app reach a folder
  /// outside its own container again after a restart.
  ///
  /// Answers `{id, name}` — the bookmark in base64 and the folder's name — or
  /// null when cancelled.
  private func pickFolder(result: @escaping FlutterResult) {
    guard pendingFolder == nil, pendingSave == nil else {
      result(FlutterError(code: "busy", message: "a picker is already open", details: nil))
      return
    }
    guard let top = Self.topViewController() else {
      result(nil)
      return
    }
    let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.folder])
    picker.delegate = self
    picker.allowsMultipleSelection = false
    pendingFolder = result
    top.present(picker, animated: true)
  }

  /// Copy a file into the chosen folder under a fixed name, replacing the one
  /// there. Written beside it and swapped in only once whole, so a copy cut
  /// short never leaves the folder without a good backup.
  ///
  /// Answers `{outcome, id?}`: outcome "saved", "denied" (the folder is gone
  /// or no longer reachable — pick it again) or "failed"; `id` is a renewed
  /// bookmark when iOS reports the old one stale.
  private func writeToFolder(_ args: [String: Any]?, result: @escaping FlutterResult) {
    guard
      let id = args?["folder"] as? String,
      let bookmark = Data(base64Encoded: id),
      let name = args?["name"] as? String, !name.isEmpty,
      let path = args?["path"] as? String,
      FileManager.default.fileExists(atPath: path)
    else {
      result(["outcome": "failed"])
      return
    }
    DispatchQueue.global(qos: .utility).async {
      var stale = false
      guard
        let folder = try? URL(
          resolvingBookmarkData: bookmark, options: [], relativeTo: nil,
          bookmarkDataIsStale: &stale)
      else {
        DispatchQueue.main.async { result(["outcome": "denied"]) }
        return
      }
      let reachable = folder.startAccessingSecurityScopedResource()
      defer { if reachable { folder.stopAccessingSecurityScopedResource() } }
      var reply: [String: Any] = ["outcome": "failed"]
      if stale, let renewed = try? folder.bookmarkData() {
        reply["id"] = renewed.base64EncodedString()
      }
      let target = folder.appendingPathComponent(name)
      let partial = folder.appendingPathComponent(name + ".partial")
      var coordinationError: NSError?
      var written = false
      NSFileCoordinator().coordinate(
        writingItemAt: target, options: .forReplacing, error: &coordinationError
      ) { destination in
        let fm = FileManager.default
        do {
          try? fm.removeItem(at: partial)
          try fm.copyItem(at: URL(fileURLWithPath: path), to: partial)
          if fm.fileExists(atPath: destination.path) {
            _ = try fm.replaceItemAt(destination, withItemAt: partial)
          } else {
            try fm.moveItem(at: partial, to: destination)
          }
          written = true
        } catch {
          try? fm.removeItem(at: partial)
        }
      }
      reply["outcome"] =
        written ? "saved" : (reachable || coordinationError != nil ? "failed" : "denied")
      DispatchQueue.main.async { result(reply) }
    }
  }

  // MARK: - UIDocumentPickerDelegate

  func documentPicker(
    _ controller: UIDocumentPickerViewController,
    didPickDocumentsAt urls: [URL]
  ) {
    if let folderResult = pendingFolder {
      pendingFolder = nil
      guard let folder = urls.first else {
        folderResult(nil)
        return
      }
      let reachable = folder.startAccessingSecurityScopedResource()
      defer { if reachable { folder.stopAccessingSecurityScopedResource() } }
      guard let bookmark = try? folder.bookmarkData() else {
        folderResult(nil)
        return
      }
      folderResult([
        "id": bookmark.base64EncodedString(),
        "name": folder.lastPathComponent,
      ])
      return
    }
    pendingSave?(urls.isEmpty ? "cancelled" : "saved")
    pendingSave = nil
  }

  func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
    if let folderResult = pendingFolder {
      pendingFolder = nil
      folderResult(nil)
      return
    }
    pendingSave?("cancelled")
    pendingSave = nil
  }

  // MARK: - UIDocumentInteractionControllerDelegate

  func documentInteractionControllerDidDismissOpenInMenu(
    _ controller: UIDocumentInteractionController
  ) {
    interaction = nil
  }

  func documentInteractionController(
    _ controller: UIDocumentInteractionController,
    didEndSendingToApplication application: String?
  ) {
    interaction = nil
  }

  // MARK: - View controller lookup

  private static func topViewController() -> UIViewController? {
    let scenes = UIApplication.shared.connectedScenes
    let root =
      scenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
      .first { $0.isKeyWindow }?
      .rootViewController
    return root.map(top(of:))
  }

  private static func top(of controller: UIViewController) -> UIViewController {
    if let presented = controller.presentedViewController {
      return top(of: presented)
    }
    if let nav = controller as? UINavigationController,
      let visible = nav.visibleViewController
    {
      return top(of: visible)
    }
    return controller
  }
}
