//
//  NoticeDetailView.swift
//  StadiumFood
//
//  Created by 이현호 on 7/14/24.
//

import SwiftUI
import WebKit

struct NoticeDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let notice: Notice
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(notice.title)
                    .bold()
                    .padding(.vertical, 3)
                
                Text("등록일 \(notice.formattedDate)")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                Divider()
                
                WebView(url: URL(string: notice.content)!)
                    .frame(height: 600)
            }
            .padding()
        }
        .navigationTitle("공지사항")
        .navigationBarBackButtonHidden()
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
