//
//  SettingsViewModel.swift
//  StadiumFood
//
//  Created by 이현호 on 7/25/24.
//

import SwiftUI
import Firebase
import FirebaseMessaging
import UserNotifications

class SettingsViewModel: ObservableObject {
    static let shared = SettingsViewModel()
    
    @Published var isPushNotificationEnabled: Bool {
        didSet {
            UserDefaults.standard.set(isPushNotificationEnabled, forKey: "isPushNotificationEnabled")
            updateNotificationSettings()
        }
    }
    
    private var notificationCenter = UNUserNotificationCenter.current()
    
    // 최신 버전 정보를 Info.plist에서 읽어오는 프로퍼티
    var latestVersion: String {
        if let latestVersion = Bundle.main.object(forInfoDictionaryKey: "LatestVersion") as? String {
            return latestVersion
        } else {
            return "Unknown"
        }
    }
    
    private init() {
        self.isPushNotificationEnabled = UserDefaults.standard.bool(forKey: "isPushNotificationEnabled")
        checkNotificationAuthorizationStatus()
    }
    
    private func checkNotificationAuthorizationStatus() {
        notificationCenter.getNotificationSettings { settings in
            DispatchQueue.main.async {
                if settings.authorizationStatus == .authorized {
                    self.updateNotificationSettings()
                } else {
                    // 알림 권한이 없는 경우
                    print("알림 권한이 없습니다.")
                }
            }
        }
    }
    
    private func updateNotificationSettings() {
        if isPushNotificationEnabled {
            // 알림 수신을 허용합니다.
            Messaging.messaging().isAutoInitEnabled = true
        } else {
            // 알림 수신을 차단합니다.
            Messaging.messaging().isAutoInitEnabled = false
        }
    }
}
