import FacebookCore
import FacebookLogin
import Flutter
import UIKit

// This should be specified by FacebookCore, but is not exposed to Swift.
let kFBSDKErrorDeveloperMessageKey = "com.facebook.sdk:FBSDKErrorDeveloperMessageKey"

func format(error: Error) -> FlutterError {
    let error = error as NSError
    var message: String?

    if let devMessage = error.userInfo[kFBSDKErrorDeveloperMessageKey] as? String? {
        message = devMessage
    }

    return FlutterError(
        code: String(describing: error.code),
        message: message,
        details: nil
    )
}

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
        guard let arguments = call.arguments as? [String: Any?] else {
            result(FlutterError(
                code: "INVALID_ARGS",
                message: "Arguments must be a Map<String, dynamic>",
                details: nil
            ))
            return
        }

        switch call.method {
        case "login":
            loginWithFacebook(arguments, result)
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

    private func loginWithFacebook(_ args: [String: Any?], _ result: @escaping FlutterResult) {
        guard let permissionNames = args["permissions"] as? [String] else {
            result(FlutterError(
                code: "INVALID_ARG",
                message: "Method 'login' requires permissions as a list of Strings.",
                details: nil
            ))
            return
        }

        let permissions = permissionNames.map { name in
            Permission(stringLiteral: name)
        }

        facebookLoginManager.logIn(
            permissions: permissions
        ) { loginResult in
            switch loginResult {
            case .cancelled:
                result([
                    "type": "cancelled",
                ])
            case .success(granted: _, declined: _, token: _):
                print("Login succeeded: \(loginResult)")
            case let .failed(error):
                result(format(error: error))
            }
        }
    }
}
