//
//  StadiumFoodApp.swift
//  StadiumFood
//
//  Created by 이현호 on 5/22/24.
//

import SwiftUI
import Firebase
import FirebaseMessaging

@main
struct StadiumFoodApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    // 앱이 켜졌을 때
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Firebase 초기화
        FirebaseApp.configure()
        
        // 원격 알림 등록
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
                if let error = error {
                    print("알림 권한 요청 실패: \(error.localizedDescription)")
                }
                print("알림 권한 승인: \(granted)")
            }
        } else {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        // Cloud Messaging delegate 설정
        Messaging.messaging().delegate = self
        
        return true
    }
}

// Cloud Messaging Delegate
extension AppDelegate: MessagingDelegate {
    
    // FCM 등록 토큰을 받았을 때
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM 토큰을 받았습니다: \(String(describing: fcmToken))")
        // FCM 토큰을 사용하여 서버에서 사용자에게 메시지를 보낼 수 있습니다.
    }
}

// User Notifications Delegate
@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
  
    // 앱이 포그라운드에 있을 때 알림이 수신될 때
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print("알림 수신: \(userInfo)")
        completionHandler([.banner, .badge, .sound])
    }

    // 사용자 알림을 탭했을 때
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("알림 탭: \(userInfo)")
        completionHandler()
    }
}
