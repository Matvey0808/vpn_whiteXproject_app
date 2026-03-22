import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var vpnChannel: FlutterMethodChannel?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    let messenger = engineBridge.applicationRegistrar.messenger()
    vpnChannel = FlutterMethodChannel(
      name: "vpn",
      binaryMessenger: messenger
    )

    vpnChannel?.setMethodCallHandler { (call, result) in
      switch call.method {
      case "startService":
        NSLog("VPN startService called on iOS")
        result("Service started")
      case "stopService":
        NSLog("VPN stopService called on iOS")
        result("Service stopped")
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }
}
