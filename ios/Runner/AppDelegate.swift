import UIKit
import Flutter
import GoogleMaps
import UserNotifications
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()
     if #available(iOS 10, *) {
         UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in })
         application.registerForRemoteNotifications()
     } else {
         let notificationSettings = UIUserNotificationSettings(types: [.badge, .alert, .sound], categories: nil)
         UIApplication.shared.registerUserNotificationSettings(notificationSettings)
         UIApplication.shared.registerForRemoteNotifications()
     }
    GeneratedPluginRegistrant.register(with: self)
      GMSServices.provideAPIKey("AIzaSyDrPuR5YYwq7e0EN0GFZ5wayWqqd6pB-0E")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

