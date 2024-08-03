//
//  ScheduleListView.swift
//  StadiumFood
//
//  Created by 이현호 on 8/3/24.
//

import SwiftUI

struct ScheduleListView: View {
    @ObservedObject var viewModel: ScheduleViewModel
    
    var body: some View {
        List(viewModel.schedules) { schedule in
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        // 구장이름
                        HStack {
                            Text(schedule.stadium)
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
        .listStyle(PlainListStyle())
    }
}

