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
                        .foregroundStyle(Color(.label))
                }
            }
        }
    }
}
