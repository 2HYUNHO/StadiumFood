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
    @Published var appStoreVersion: String = "정보 없음"
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
        fetchAppStoreVersion()
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
    func fetchAppStoreVersion() {
        let appID = "6553999145"
        guard let url = URL(string: "https://itunes.apple.com/kr/lookup?id=\(appID)") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.appStoreVersion = "정보 없음"
                }
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let results = json["results"] as? [[String: Any]],
               let version = results.first?["version"] as? String {
                DispatchQueue.main.async {
                    self?.appStoreVersion = version
                }
            } else {
                DispatchQueue.main.async {
                    self?.appStoreVersion = "정보 없음"
                }
            }
        }.resume()
    }
}
