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
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                
                Text("\(viewModel.formatterDate(date)) 경기")
                    .font(.headline)
                    .padding(.leading)
                    .padding(.bottom, 10)
                
                Spacer()
            }
            
            HStack {
                Text("HOME")
                    .bold()
                    .padding(.trailing)
                    .frame(maxWidth: .infinity)
                Spacer()
                
                Text("AWAY")
                    .bold()
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
            }
            
            if viewModel.schedules.isEmpty {
                VStack {
                    Divider()
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Text("경기일정이 없습니다.")
                            .foregroundStyle(.gray)
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                .frame(maxHeight: .infinity)
            } else {
                ScrollView {
                    ForEach(viewModel.schedules) { schedule in
                        VStack {
                            HStack {
                                // 홈팀
                                HStack {
                                    Spacer()
                                    
                                    Text(schedule.home)
                                        .font(.system(size: 14).bold())
                                        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                                    
                                    Spacer()
                                }
                                
                                VStack {
                                    Text("vs")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundStyle(.blue)
                                    
                                    Text(schedule.date, formatter: CalendarViewModel.timeFormatter)
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                                
                                // 어웨이팀
                                HStack {
                                    Spacer()
                                    
                                    Text(schedule.away)
                                        .font(.system(size: 14).bold())
                                        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                                    
                                    Spacer()
                                }
                            }
                            .padding(.vertical, 2)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        }
                        .frame(maxHeight: .infinity)
                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
