import FacebookCore
import FacebookLogin
import Flutter
import UIKit

public class SwiftFacebookPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "actionsprout.com/facebook", binaryMessenger: registrar.messenger())
        let instance = SwiftFacebookPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance)
    }

    let facebookLoginManager: LoginManager

    public override init() {
        facebookLoginManager = LoginManager()
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        default:
            result(FlutterError(
                code: "UNIMPLEMENTED",
                message: "Method \(call.method) not implemented",
                details: nil
            ))
        }
    }

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable: Any]) -> Bool {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions as? [UIApplication.LaunchOptionsKey: Any])
        return true
    }

    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return ApplicationDelegate.shared.application(app, open: url, options: options)
    }
}
