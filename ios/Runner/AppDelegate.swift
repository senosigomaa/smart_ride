import Flutter
import UIKit
import GoogleMaps // 1. استدعاء مكتبة خرائط جوجل

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // 2. وضع مفتاح الـ API الخاص بجوجل هنا
    GMSServices.provideAPIKey("AIzaSyATGrtEbwDVRac_56kelsihef62SW3EAYw")
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
