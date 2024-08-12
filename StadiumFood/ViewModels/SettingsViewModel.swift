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
    
    @Published var appVersion: AppVersion?
    @Published var isPushNotificationEnabled: Bool {
        didSet {
            UserDefaults.standard.set(isPushNotificationEnabled, forKey: "isPushNotificationEnabled")
            updateNotificationSettings()
        }
    }
    
    // 현재 앱 버전 정보
    var currentVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "정보 없음"
    }
    
    private var notificationCenter = UNUserNotificationCenter.current()
    
    private init() {
        self.isPushNotificationEnabled = UserDefaults.standard.bool(forKey: "isPushNotificationEnabled")
        checkNotificationAuthorizationStatus()
        fetchVersion()
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
    
    // 앱스토어 버전 정보 가져오기
    func fetchVersion() {
        Firestore.firestore().collection("version").document("latest").getDocument { document, error in
            if let error = error {
                print("Error fetching version: \(error.localizedDescription)")
            } else if let document = document, document.exists {
                let data = document.data()
                let latestVersion = data?["latestVersion"] as? String ?? "정보 없음"
                
                DispatchQueue.main.async {
                    self.appVersion = AppVersion(id: document.documentID, latestVersion: latestVersion)
                }
            } else {
                DispatchQueue.main.async {
                    self.appVersion = nil
                }
            }
        }
    }
}
