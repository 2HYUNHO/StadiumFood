//
//  SettingsView.swift
//  StadiumFood
//
//  Created by 이현호 on 7/14/24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel.shared
    @State private var showToast = false
    @State private var toastMessage = ""
    let myEmail = "gujangfood" + "@"  + "gmail.com"

    private var versionStatus: String {
        if let currentVersion = Bundle.main.appVersion {
            return currentVersion == viewModel.latestVersion ? "(최신)" : "(업데이트 필요"
        } else {
            return "(버전 확인 불가)"
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
                            Text("v \(Bundle.main.appVersion ?? "Unknown") \(versionStatus)")
                                .foregroundStyle(.gray)
                        }
                        .padding(.bottom, 12)
                        
                        // 알림 설정
                        Toggle(isOn: $viewModel.isPushNotificationEnabled) {
                            Label("알림기능", systemImage: "bell")
                                .padding(.bottom, 12)
                        }
                        .toggleStyle(SwitchToggleStyle(tint: Color.green))
                        
                        // 앱 공유하기
                        ShareLink(item: URL(string: "https://apps.apple.com/app/%EA%B5%AC%EC%9E%A5%EB%A8%B9%EA%B1%B0%EB%A6%AC/id6553999145")!) {
                            Label("앱 공유하기", systemImage: "square.and.arrow.up")
                                .padding(.bottom, 12)
                        }
                        
                        // 약관 및 정책
                        NavigationLink(destination: TermsOfServiceView()) {
                            Label("서비스 이용약관", systemImage: "doc.text")
                                .padding(.bottom, 12)
                        }
                        
                        NavigationLink(destination: PrivacyPolicyView()) {
                            Label("개인정보처리방침", systemImage: "lock.shield")
                                .padding(.bottom, 12)
                        }
                    }
                    .listRowSeparator(.hidden, edges: .bottom)
                }
                .listStyle(.plain)
                .navigationBarTitle("설정", displayMode: .inline)
                
                Spacer()
                
                // Toast 메시지 뷰
                ToastView(message: toastMessage, isShowing: $showToast)
                
                // 문의 및 제보 버튼
                Button(action: {
                    UIPasteboard.general.string = "gujangfood@email.com"
                    toastMessage = "클립보드에 복사되었습니다."
                    showToast = true
                    
                    // 1초 후에 Toast 메시지 숨기기
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        showToast = false
                    }
                }) {
                    Label("문의 및 제보 \(myEmail)" , systemImage: "doc.on.doc")
                        .labelStyle(.titleAndIcon)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .padding()
                }
            }
        }
    }
}
