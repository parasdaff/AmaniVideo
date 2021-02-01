import UIKit
import AmaniVideo

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate{
    
    var window: UIWindow?
    
    let amaniSDKNotificationCenter = AmaniVideoSDKNotificationWrapper.sharedInstance
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.amaniSDKNotificationCenter.initialSDKNotificationSetup()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    public func registerForNotification() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                if (error == nil) {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        }
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let textResponse = response as? UNTextInputNotificationResponse {
            let reply = textResponse.userText
            _ = self.amaniSDKNotificationCenter.sdkLocalNotificationBelongs(identifier: response.notification.request.identifier,content:reply)
            // Send reply message
        } else {
            let belongsTOSDK = self.amaniSDKNotificationCenter.sdkLocalNotificationBelongs(identifier: response.notification.request.identifier,content:nil)
            if !belongsTOSDK && response.notification.request.identifier == "user_notification" {
                NotificationCenter.default.post(name: NSNotification.Name("HandleNotification"), object: nil, userInfo: ["action" : "user_notification"])
            }
        }
        completionHandler()
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        _ = self.amaniSDKNotificationCenter.sdkLocalNotificationBelongs(identifier: notification.request.content.categoryIdentifier, content: nil)
        completionHandler(.alert)
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        _ = self.amaniSDKNotificationCenter.sdkLocalNotificationBelongs(identifier: notification.category!, content: nil)
    }
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        
        _ = self.amaniSDKNotificationCenter.sdkLocalNotificationBelongs(identifier: notification.category!, content: nil)
        completionHandler()
    }
    
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        self.amaniSDKNotificationCenter.setSDKApnsNormalToken(deviceToken: deviceToken.base64EncodedString())
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for notifications: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //print(userInfo)
        _ = self.amaniSDKNotificationCenter.sdkRemoteNotificationBelongs(userInfo: userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
        
    
    
    
    
    
}

