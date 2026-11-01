import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  // The app outlives its window, as Mac apps do: closing it keeps the relay
  // socket open and messages arriving, and the Dock icon brings it back.
  // Cmd+Q is the way out. There is no push to wake a computer
  // (docs/superpowers/specs/2026-11-01-desktop-tray-design.md).
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return false
  }

  override func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
    if !flag {
      for window in sender.windows {
        window.makeKeyAndOrderFront(self)
      }
    }
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }
}
