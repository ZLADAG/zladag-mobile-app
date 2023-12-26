//
//  AppDelegate.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//

/*
 MARK: == IMPORTANT ==
 
 UIVIEW TAGS:
 451 -> MainHeaderCollectionReusableView
 461 -> TanggalReservationCollectionViewCell
 462 -> AnabulReservationCollectionViewCell
 
 500 + i -> ReservationTextView; i = indexPath.row

 
 */

import UIKit
import Firebase
import FirebaseMessaging
import GooglePlaces

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let gcmMessageIDKey: String = "gcm.Message_ID"
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // PUSH NOTIFICATIONS
//        setupUserNotifications(application: application)
        
        
        
        GMSPlacesClient.provideAPIKey(LocationManager.googleMapsAPIKey)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        window.rootViewController = TabBarViewController()
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func setupUserNotifications(application: UIApplication) {
        
        FirebaseApp.configure()
                
        UNUserNotificationCenter.current().delegate = self

//        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        let authOptions: UNAuthorizationOptions = .badge
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )

        application.registerForRemoteNotifications()
        
        // MESSAGING DELEGATE
        
        Messaging.messaging().delegate = self
        
        
//        self.sendBasicNotification(timeInterval: 5)
        
    }
    
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")

        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
        
        let fcmTokenBody = FirebaseCloudMessagingToken(firebaseCloudMessagingToken: fcmToken ?? "123NOTOKEN123")
        APICaller.shared.postFcmToken(firebaseCloudMessagingToken: fcmTokenBody) { result in
            switch result {
            case .success(let response):
                print("/nPOST FCM TOKEN RESPONSE:")
                print(response)
                break
            case .failure(let error):
                print("\nERROR WHEN POST FCM TOKEN")
                print(error)
                print()
            }
        }

        print("\nDOING POST FCM TOKEN!")
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
  // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)

        // ...

        // Print full message.
        print("\nKEPANGGIL!")
        print(userInfo)
        
        NotificationCenter.default.post(name: Notification.Name("cobaText"), object: nil)
        
        // Change this to your preferred presentation option
        return .banner
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo

        // ...

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)

        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async -> UIBackgroundFetchResult {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)

        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        // Print full message.
        print(userInfo)

        return UIBackgroundFetchResult.newData
    }

    
    func sendBasicNotification(timeInterval: TimeInterval) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .badge]) { granted, error in
            if let error = error {
                // Handle errors
                return
            }
            
            guard granted else { return }
            // Configure the content of the notification
            let content = UNMutableNotificationContent()
            content.title = "GET THE FOOD OUT OF THE OVEN!!!"
            content.body = "Don't let it burn and end up ordering food again."
            
            // Configure the trigger
//            let timeInterval: Double = 1 * 60 * 60 // One hour
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            
            // Create the notification request
            let id = "basicNotification"
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            
            // Schedule the notification
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.add(request) { error in
                if let error = error {
                    print("Not able to add notification: \(error.localizedDescription)")
                }
            }
        }
    }
    
}

