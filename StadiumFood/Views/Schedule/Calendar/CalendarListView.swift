//
//  ScheduleListView.swift
//  StadiumFood
//
//  Created by 이현호 on 8/3/24.
//

import SwiftUI

struct CalendarListView: View {
    @ObservedObject var viewModel: ScheduleViewModel
    let date: Date
    
    // 날짜 포맷터
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일 경기"  // "8월 3일" 형태로 포맷
        return formatter
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                
                Text(dateFormatter.string(from: date))
                    .font(.headline)
                    .padding(.leading)
                    .padding(.bottom, 10)
                
                Spacer()
            }
            
            HStack {
                Text("Home")
                    .bold()
                    .padding(.leading)
                
                Spacer()
                
                Text("Away")
                    .bold()
                    .padding(.trailing)
            }

            List(viewModel.schedules) { schedule in
                HStack {
                    Text(schedule.home) // 홈팀
                    
                    Spacer()
                    
                    Text("vs")
                    
                    Spacer()
                    
                    Text(schedule.away) // 어웨이팀
                }
                
                .padding(.bottom, 5)
            }
            .listStyle(.plain)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
