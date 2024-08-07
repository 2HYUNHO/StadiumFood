//
//  ScheduleView.swift
//  StadiumFood
//
//  Created by 이현호 on 8/3/24.
//

import SwiftUI

struct ScheduleView: View {
    @StateObject var scheduleViewModel = ScheduleViewModel()
    @StateObject var calendarViewModel = CalendarViewModel()
    @State private var showCalendar: Bool = false
    @State private var selectedDate: Date = Date() // 선택된 날짜 상태 추가
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                DatePickerView(viewModel: calendarViewModel)
                    .onChange(of: calendarViewModel.currentDate) { newDate in
                        selectedDate = newDate
                        Task {
                            await scheduleViewModel.fetchSchedules(for: newDate)
                        }
                    }
                
                Text("📢 우천취소나 더블헤더로 일정이 변경될 수 있습니다.")
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
                    .padding(.leading)
                
                TabView(selection: $selectedDate) {
                    ForEach(calendarViewModel.dates) { calendarDate in
                        ScheduleListView(viewModel: scheduleViewModel, selectedDate: $selectedDate)
                            .tag(calendarDate.date)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onChange(of: selectedDate) { newDate in
                    // 날짜가 변경되면 새 날짜를 기준으로 데이터 업데이트
                    Task {
                        await scheduleViewModel.fetchSchedules(for: newDate)
                    }
                    calendarViewModel.updateDates(for: newDate)
                }
                
                Spacer()
            }
            .fullScreenCover(isPresented: $showCalendar, onDismiss: {
                // fullScreenCover가 닫힐 때 selectedDate를 현재날짜로 초기화
                selectedDate = calendarViewModel.currentDate
                Task {
                    await scheduleViewModel.fetchSchedules(for: selectedDate)
                }
            }) {
                CalendarView(calendarViewModel: calendarViewModel, scheduleViewModel: scheduleViewModel)
            }
            .navigationTitle("경기일정")
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
                // 처음 실행 시 현재 날짜를 선택된 날짜로 설정
                selectedDate = calendarViewModel.currentDate
                Task {
                    await scheduleViewModel.fetchSchedules(for: selectedDate)
                }
            }
        }
    }
}
