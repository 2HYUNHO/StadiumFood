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
    @State private var appStoreVersion: String? = nil
    let myEmail = "gujangfood" + "@"  + "gmail.com"
    
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
                        
                        // 알림 설정
                        Toggle(isOn: $viewModel.isPushNotificationEnabled) {
                            Label("알림기능", systemImage: "bell")
                                .padding(.bottom, 12)
                        }
                        .toggleStyle(SwitchToggleStyle(tint: Color(hex: 0xC54D51)))
                        
                        // 약관 및 정책
                        NavigationLink(destination: TermsOfServiceView()) {
                            Label("서비스 이용약관", systemImage: "doc.text")
                                .padding(.bottom, 12)
                        }
                        
                        NavigationLink(destination: PrivacyPolicyView()) {
                            Label("개인정보처리방침", systemImage: "lock.shield")
                                .padding(.bottom, 12)
                        }
                        
                        HStack {
                            HStack {
                                Image(systemName: "info.circle")
                                    .font(.system(size: 20))
                                    .padding(.trailing, 8)
                                
                                VStack(alignment: .leading) {
                                    Text("버전정보")
                                    
                                    Text("최신버전 \(viewModel.appVersion?.latestVersion ?? "정보 없음")")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                                .padding(.leading, 3)
                            }
                            Spacer()
                            
                            Text("\(viewModel.currentVersion)")
                                .foregroundStyle(Color(hex: 0xC54D51))
                        }
                        .padding(.leading, 2)
                        .padding(.bottom, 12)
                    }
                    .listRowSeparator(.hidden, edges: .bottom)
                }
                .listStyle(.plain)
                
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
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("설정")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.black)
                        .bold()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
