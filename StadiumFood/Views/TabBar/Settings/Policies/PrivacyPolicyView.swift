//
//  PrivacyPolicyView.swift
//  StadiumFood
//
//  Created by 이현호 on 7/31/24.
//

import SwiftUI
import WebKit

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        PolicyWebView(url: URL(string: "https://green-pangolin-de4.notion.site/e1b8e8125b9d4d12913d8236783bd89e")!)
            .navigationBarBackButtonHidden()
            .navigationTitle("개인정보처리방침")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 16))
                            .foregroundStyle(.black)
                    }
                }
            }
    }
}
