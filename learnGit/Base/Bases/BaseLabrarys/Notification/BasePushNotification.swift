//
//  BasePushNotification.swift
//  VegaFintech
//
//  Created by THONG TRAN on 09/10/2021.
//  Copyright © 2021 Vega. All rights reserved.
//


//  https://drive.google.com/open?id=0BwW91GDbFQ_SejV2ZUFNcTJnTFZ5SGJYY1RmclliNHoybExB
//  https://www.raywenderlich.com/11395893-push-notifications-tutorial-getting-started


import UIKit
import UserNotificationsUI
import UserNotifications
import UserNotifications

class BasePushNotification: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    fileprivate let viewActionIdentifier = "VIEW_IDENTIFIER"
    fileprivate let newsCategoryIdentifier = "NEWS_CATEGORY"
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //        let notificationTypes : UIUserNotificationType = [.alert, .badge, .sound]
        //        let notificationSettings : UIUserNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        //        UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        
        //        if #available(iOS 10.0, *) {
        //            let center = UNUserNotificationCenter.current()
        //            center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
        //                // Enable or disable features based on authorization.
        //            }
        //        }
        //        else
        //        {
        //            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
        //        }
        //        UIApplication.shared.registerForRemoteNotifications()
        
        //registerForPushNotifications()
        registerForPushNotifications()
        
        return true
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            
            let viewAction = UNNotificationAction(identifier: self.viewActionIdentifier,
                                                  title: "View",
                                                  options: [.foreground])
            
            let newsCategory = UNNotificationCategory(identifier: self.newsCategoryIdentifier,
                                                      actions: [viewAction],
                                                      intentIdentifiers: [],
                                                      options: [])
            
            UNUserNotificationCenter.current().setNotificationCategories([newsCategory])
            
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        UNUserNotificationCenter.current().delegate = self
    }
    
    // get Device Token ----------------
    func application(_ application: UIApplication,didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("=======dang nhan")
        print(userInfo)
        //print(userInfo.values.first!)
        print(userInfo[AnyHashable("aps")]!)
        var var1 = userInfo[AnyHashable("aps")]
        if let var2 = var1 as? [String:Any]  {
            print(var2["user"]!)
        }
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
    }
    
    
    
    
    
    func registerForPushNotifications3() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
        }
    }
    
    func registerForPushNotifications5() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            // 1. Check if permission granted
            guard granted else { return }
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    
    func registerForPushNotifications1() {
        let notifSetting = UIUserNotificationSettings.init(types: [.alert,.badge,.sound], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(notifSetting)
        
        UIApplication.shared.registerForRemoteNotifications()
    }
}





