//
//  NoticeListView.swift
//  StadiumFood
//
//  Created by 이현호 on 7/14/24.
//

import SwiftUI

struct NoticeListView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel = NoticesViewModel()
    
    var body: some View {
        if viewModel.notices.isEmpty {
            VStack {
                Spacer()
                
                Text("공지사항이 없습니다.")
                    .foregroundStyle(.gray)
            }
        }
        
        List(viewModel.notices) { notice in
            NavigationLink(destination: NoticeDetailView(notice: notice)) {
                VStack(alignment:.leading, spacing: 10) {
                    Text(notice.title)
                        .font(.headline)
                    Text(notice.formattedDate)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                .padding(.vertical, 2)
            }
        }
        .navigationBarBackButtonHidden()
        .listStyle(.plain)
        .navigationTitle("공지사항")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchNotices()
        }
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
