//
//  TermsOfServiceView.swift
//  StadiumFood
//
//  Created by 이현호 on 7/31/24.
//

import SwiftUI
import WebKit

struct TermsOfServiceView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        PolicyWebView(url: URL(string: "https://green-pangolin-de4.notion.site/b8deb58274694754924e2dcea0a66385?pvs=4")!)
            .navigationBarBackButtonHidden()
            .navigationTitle("서비스 이용약관")
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
