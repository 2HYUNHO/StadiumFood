//
//  NoticeDetailView.swift
//  StadiumFood
//
//  Created by 이현호 on 7/14/24.
//

import SwiftUI

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
                
                Text(notice.content)
                    .font(.body)
                    .padding(.vertical)
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
                        .foregroundStyle(Color(.label))
                }
            }
        }
    }
}
