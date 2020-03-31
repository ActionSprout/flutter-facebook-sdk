import Flutter
import UIKit

public class SwiftFacebookPlugin: NSObject, FlutterPlugin, FlutterApplicationLifeCycleDelegate {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "actionsprout.com/facebook", binaryMessenger: registrar.messenger())
        let instance = SwiftFacebookPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_: FlutterMethodCall, result: @escaping FlutterResult) {
        result("iOS " + UIDevice.current.systemVersion)
    }
}
