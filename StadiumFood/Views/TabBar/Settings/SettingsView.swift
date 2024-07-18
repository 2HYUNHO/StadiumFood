import SwiftUI

struct SettingsView: View {
    @State private var isDarkMode = false
    @State private var isPushNotificationEnabled = true
    @State private var isEmailNotificationEnabled = false
    @State private var isSMSNotificationEnabled = false
    
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
                        }
                        
                        HStack {
                            Label("버전정보", systemImage: "info.circle")
                            Spacer()
                            Text("v\(Bundle.main.appVersion ?? "Unknown") \(versionStatus)")
                                .foregroundStyle(.gray)
                        }
                        
                        // 알림 설정
                        Toggle(isOn: $isPushNotificationEnabled) {
                            Label("알림기능", systemImage: "bell")
                        }
                        
                        // 앱 공유하기
                        ShareLink(item: URL(string: "https://www.example.com")!) {
                            Label("앱 공유하기", systemImage: "square.and.arrow.up")
                        }
                        
                        // 약관 및 정책
                        NavigationLink(destination: Text("서비스 이용약관")) {
                            Label("서비스 이용약관", systemImage: "doc.text")
                        }
                        
                        NavigationLink(destination: Text("개인정보처리방침")) {
                            Label("개인정보처리방침", systemImage: "lock.shield")
                        }
                    }
                    .padding(.vertical, 5)
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
}
