//
//  ScheduleView.swift
//  StadiumFood
//
//  Created by 이현호 on 8/3/24.
//

import SwiftUI

struct ScheduleView: View {
    @ObservedObject var calendarViewModel: CalendarViewModel
    @ObservedObject var scheduleViewModel: ScheduleViewModel
    @State private var showCalendar: Bool = false
    @State private var selectedDate: Date = Date() // 선택된 날짜 상태 추가
    
    var body: some View {
        NavigationView {
            VStack {
                DatePickerView(viewModel: calendarViewModel)
                    .onChange(of: calendarViewModel.currentDate) { newDate in
                        selectedDate = newDate
                        scheduleViewModel.fetchSchedules(for: newDate)
                    }
                TabView(selection: $calendarViewModel.currentDate) {
                    ForEach(calendarViewModel.dates) { calendarDate in
                        ScheduleListView(viewModel: scheduleViewModel)
                            .tag(calendarDate.date)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .onChange(of: selectedDate) { newDate in
                    // 날짜가 변경되면 새 날짜를 기준으로 데이터 업데이트
                    scheduleViewModel.fetchSchedules(for: newDate)
                    calendarViewModel.updateDates(for: newDate)
                }
                
                Spacer()
            }
            .fullScreenCover(isPresented: $showCalendar) {
                CalendarView(scheduleViewModel: scheduleViewModel)
            }
            //            .transaction { transaction in
            //                transaction.disablesAnimations = true
            //            }
            .navigationTitle("야구일정")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showCalendar = true
                    } label: {
                        Image(systemName: "calendar")
                            .font(.system(size: 16))
                            .foregroundStyle(Color(.label))
                    }
                }
            }
            .onAppear {
                // 초기화 시 현재 날짜를 선택된 날짜로 설정
                selectedDate = calendarViewModel.currentDate
            }
        }
    }
}
