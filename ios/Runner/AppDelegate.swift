import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(
            name: "com.aswat.alquloob/keyboard",
            binaryMessenger: controller.binaryMessenger
        )

        channel.setMethodCallHandler { (call, result) in
            switch call.method {
            case "isKeyboardEnabled":
                let bundleID = Bundle.main.bundleIdentifier ?? ""
                let extID = "\(bundleID).AswatKeyboard"
                if let keyboards = UserDefaults.standard.object(forKey: "AppleKeyboards") as? [String] {
                    result(keyboards.contains(extID))
                } else {
                    result(false)
                }
            case "openKeyboardSettings":
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
                result(nil)
            case "switchToKeyboard":
                // iOS does not allow programmatic keyboard switching.
                result(nil)
            default:
                result(FlutterMethodNotImplemented)
            }
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
