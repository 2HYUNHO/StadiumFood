//
//  SettingsView.swift
//  StadiumFood
//
//  Created by 이현호 on 7/14/24.
//

import SwiftUI
import Firebase
import FirebaseMessaging
import UserNotifications

struct SettingsView: View {
    @State private var isPushNotificationEnabled: Bool = UserDefaults.standard.bool(forKey: "isPushNotificationEnabled")
    
    private let latestVersion = "1.0.0" // 최신 버전 정보
    
    private var versionStatus: String {
        if Bundle.main.appVersion == latestVersion {
            return "(최신)"
        } else {
            return "(업데이트 필요)"
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Group {
                        // 공지사항 및 버전 정보
                        NavigationLink(destination: NoticeListView()) {
                            Label("공지사항", systemImage: "megaphone")
                                .padding(.bottom, 12)
                        }
                        
                        HStack {
                            Label("버전정보", systemImage: "info.circle")
                            Spacer()
                            Text("v\(Bundle.main.appVersion ?? "Unknown") \(versionStatus)")
                                .foregroundStyle(.gray)
                        }
                        .padding(.bottom, 12)
                        
                        // 알림 설정
                        Toggle(isOn: $isPushNotificationEnabled) {
                            Label("알림기능", systemImage: "bell")
                                .padding(.bottom, 12)
                        }
                        .onChange(of: isPushNotificationEnabled) { newValue in
                            UserDefaults.standard.set(newValue, forKey: "isPushNotificationEnabled")
                            
                            if newValue {
                                subscribeToAlertsTopic()
                            } else {
                                unsubscribeFromAlertsTopic()
                            }
                        }
                        .onAppear {
                            restoreNotificationSettings()
                        }
                        
                        // 앱 공유하기
                        ShareLink(item: URL(string: "https://www.example.com")!) {
                            Label("앱 공유하기", systemImage: "square.and.arrow.up")
                                .padding(.bottom, 12)
                        }
                        
                        // 약관 및 정책
                        NavigationLink(destination: Text("서비스 이용약관")) {
                            Label("서비스 이용약관", systemImage: "doc.text")
                                .padding(.bottom, 12)
                        }
                        
                        NavigationLink(destination: Text("개인정보처리방침")) {
                            Label("개인정보처리방침", systemImage: "lock.shield")
                                .padding(.bottom, 12)
                        }
                    }
                    .listRowSeparator(.hidden, edges: .bottom)
                }
                .listStyle(.plain)
                .navigationBarTitle("설정", displayMode: .inline)
                
                Spacer()
                
                Button {
                    UIPasteboard.general.string = "StadiumFood@email.com"
                } label: {
                    Label("문의 및 제보 StadiumFood\("@")email.com", systemImage: "doc.on.doc")
                        .labelStyle(.titleAndIcon)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .padding()
                }
            }
        }
    }
    
    private func restoreNotificationSettings() {
        // UserDefaults에서 알림 상태 읽기
        isPushNotificationEnabled = UserDefaults.standard.bool(forKey: "isPushNotificationEnabled")
        
        // 알림 기능 상태에 따라 FCM 주제 구독/해제
        if isPushNotificationEnabled {
            subscribeToAlertsTopic()
        } else {
            unsubscribeFromAlertsTopic()
        }
    }
    
    private func subscribeToAlertsTopic() {
        Messaging.messaging().subscribe(toTopic: "Alerts") { error in
            if let error = error {
                print("FCM 구독 실패: \(error.localizedDescription)")
            } else {
                print("FCM 구독 성공")
            }
        }
    }
    
    private func unsubscribeFromAlertsTopic() {
        Messaging.messaging().unsubscribe(fromTopic: "Alerts") { error in
            if let error = error {
                print("FCM 구독 해제 실패: \(error.localizedDescription)")
            } else {
                print("FCM 구독 해제 성공")
            }
        }
    }
}
