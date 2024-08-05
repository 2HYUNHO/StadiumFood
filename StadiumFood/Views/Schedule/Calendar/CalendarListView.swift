//
//  ScheduleListView.swift
//  StadiumFood
//
//  Created by 이현호 on 8/3/24.
//

import SwiftUI

struct CalendarListView: View {
    @StateObject var viewModel = CalendarViewModel()
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
                Text("HOME")
                    .bold()
                    .padding(.leading)
                
                Spacer()
                
                Text("AWAY")
                    .bold()
                    .padding(.trailing)
            }
            
            if viewModel.schedules.isEmpty {
                VStack {
                    HStack {
                        Spacer()
                        
                        Text("경기일정이 없습니다.")
                            .foregroundStyle(.gray)
                        
                        Spacer()
                    }
                }
                .frame(maxHeight: .infinity)
            } else {
                ForEach(viewModel.schedules) { schedule in
                    VStack {
                        HStack {
                            // 홈팀
                            HStack {
                                Text(schedule.home)
                                    .font(.system(size: 14).bold())
                                    .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                                
                                Spacer()
                            }
                            
                            Text("vs")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(.blue)
                            
                            // 어웨이팀
                            HStack {
                                Spacer()
                                
                                Text(schedule.away)
                                    .font(.system(size: 14).bold())
                                    .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .frame(maxHeight: .infinity)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
