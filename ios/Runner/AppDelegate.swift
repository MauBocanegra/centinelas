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
      GMSServices.provideAPIKey("AIzaSyDgsZE2Fs9Di2keB4y2cuk9i_nw9vaHd1g")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

