//
//  ScheduleListView.swift
//  StadiumFood
//
//  Created by 이현호 on 8/3/24.
//

import SwiftUI
import Kingfisher

struct ScheduleListView: View {
    @StateObject var viewModel = ScheduleViewModel()
    @Binding var selectedDate: Date
    
    var body: some View {
        if viewModel.schedules.isEmpty {
            VStack {
                Text("경기일정이 없습니다.")
                    .foregroundStyle(.gray)
            }
        } else {
            List(viewModel.schedules) { schedule in
                VStack(alignment: .leading) {
                    HStack {
                        // 구장사진
                        KFImage(URL(string: schedule.stadiumImage))
                            .resizable()
                            .placeholder {
                                ProgressView()
                            }
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            // 구장이름
                            HStack {
                                Text(schedule.stadiumName)
                                    .padding(.bottom, 3)
                                    .font(.system(size: 18))
                                    .bold()
                            }
                            
                            // 경기 팀
                            HStack(alignment: .bottom) {
                                Text(schedule.home)
                                    .font(.system(size: 14))
                                
                                Text("vs")
                                    .font(.system(size: 14))
                                
                                Text(schedule.away)
                                    .font(.system(size: 14))
                                
                            }
                            
                            // 날짜 및 시간
                            Text(viewModel.formattedDate(for: schedule.date))
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        .padding(.leading, 5)
                    }
                }
            }
            .refreshable {
                await viewModel.reload(for: selectedDate)
            }
            .listStyle(PlainListStyle())
        }
    }
}

