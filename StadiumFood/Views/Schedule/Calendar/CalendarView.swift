//
//  CalendarView.swift
//  StadiumFood
//
//  Created by 이현호 on 8/3/24.
//

import SwiftUI

struct CalendarView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var calendarViewModel = CalendarViewModel()
    @StateObject var scheduleViewModel = ScheduleViewModel()
    
    var body: some View {
        VStack {
            headerView
            calendarGridView
            
            if let selectedDate = calendarViewModel.selectedDate {
                CalendarListView(viewModel: calendarViewModel, date: selectedDate)
                    .onAppear {
                        // 선택된 날짜에 대한 스케줄을 가져옵니다.
                        calendarViewModel.fetchSchedules(for: selectedDate)
                    }
            }
            
            Spacer()
        }
        .padding()
        
        .onAppear {
            // CalendarView가 나타날 때 항상 현재 날짜로 설정
            calendarViewModel.selectedDate = calendarViewModel.today
            calendarViewModel.fetchSchedules(for: calendarViewModel.selectedDate ?? calendarViewModel.today)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                calendarViewModel.resetToToday()
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    // MARK: - 헤더 뷰
    private var headerView: some View {
        VStack {
            HStack {
                Spacer()
                
                yearMonthView
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(Color(.label))
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 20)
            
            HStack {
                ForEach(CalendarViewModel.weekdaySymbols.indices, id: \.self) { symbol in
                    Text(CalendarViewModel.weekdaySymbols[symbol].uppercased())
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 5)
        }
    }
    
    // MARK: - 연월 표시
    private var yearMonthView: some View {
        HStack(alignment: .center, spacing: 20) {
            Button {
                calendarViewModel.changeMonth(by: -1)
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundStyle(calendarViewModel.canMoveToPreviousMonth() ? Color(.label) : .gray)
            }
            .disabled(!calendarViewModel.canMoveToPreviousMonth())
            
            Text(calendarViewModel.month, formatter: CalendarViewModel.calendarHeaderDateFormatter)
                .font(.title.bold())
            
            Button {
                calendarViewModel.changeMonth(by: 1)
            } label: {
                Image(systemName: "chevron.right")
                    .font(.title)
                    .foregroundStyle(calendarViewModel.canMoveToNextMonth() ? Color(.label) : .gray)
            }
            .disabled(!calendarViewModel.canMoveToNextMonth())
        }
    }
    
    // MARK: - 날짜 그리드 뷰
    private var calendarGridView: some View {
        let daysInMonth: Int = calendarViewModel.numberOfDays(in: calendarViewModel.month)
        let firstWeekday: Int = calendarViewModel.firstWeekdayOfMonth(in: calendarViewModel.month) - 1
        let lastDayOfMonthBefore = calendarViewModel.numberOfDays(in: calendarViewModel.previousMonth())
        let numberOfRows = Int(ceil(Double(daysInMonth + firstWeekday) / 7.0))
        let visibleDaysOfNextMonth = numberOfRows * 7 - (daysInMonth + firstWeekday)
        
        return LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
            ForEach(-firstWeekday ..< daysInMonth + visibleDaysOfNextMonth, id: \.self) { index in
                Group {
                    if index > -1 && index < daysInMonth {
                        let date = calendarViewModel.getDate(for: index)
                        let day = Calendar.current.component(.day, from: date)
                        let clicked = calendarViewModel.selectedDate == date
                        let isToday = date.formattedCalendarDayDate == calendarViewModel.today.formattedCalendarDayDate
                        
                        CellView(day: day, clicked: clicked, isToday: isToday)
                    } else if let prevMonthDate = Calendar.current.date(
                        byAdding: .day,
                        value: index + lastDayOfMonthBefore,
                        to: calendarViewModel.previousMonth()
                    ) {
                        let day = Calendar.current.component(.day, from: prevMonthDate)
                        
                        CellView(day: day, isCurrentMonthDay: false)
                    }
                }
                .onTapGesture {
                    if 0 <= index && index < daysInMonth {
                        let date = calendarViewModel.getDate(for: index)
                        calendarViewModel.selectedDate = date
                        calendarViewModel.fetchSchedules(for: date)
                    }
                }
            }
        }
    }
    
    private struct CellView: View {
        @Environment(\.colorScheme) var colorScheme: ColorScheme
        
        private var day: Int
        private var clicked: Bool
        private var isToday: Bool
        private var isCurrentMonthDay: Bool
        private var textColor: Color {
            if clicked {
                return colorScheme == .dark ? Color.black : Color.white
            } else if isCurrentMonthDay {
                return isToday ? (colorScheme == .dark ? Color.black : Color.white) : (colorScheme == .dark ? Color.white : Color.black)
            } else {
                return colorScheme == .dark ? Color.gray : Color.gray
            }
        }
        
        private var backgroundColor: Color {
            if clicked {
                return isToday ? (colorScheme == .dark ? Color.white : Color.black) : (colorScheme == .dark ? Color.gray : Color.gray)
            } else if isToday {
                // 오늘 날짜일 때 배경 색상 조정
                return colorScheme == .dark ? Color.white : Color.black
            } else {
                // 오늘 날짜가 아닐 때 배경 색상 조정
                return colorScheme == .dark ? Color.black : Color.white
            }
        }
        
        fileprivate init(
            day: Int,
            clicked: Bool = false,
            isToday: Bool = false,
            isCurrentMonthDay: Bool = true
        ) {
            self.day = day
            self.clicked = clicked
            self.isToday = isToday
            self.isCurrentMonthDay = isCurrentMonthDay
        }
        
        fileprivate var body: some View {
            VStack {
                Circle()
                    .fill(backgroundColor)
                    .overlay(Text(String(day)))
                    .foregroundStyle(textColor)
                
                Spacer()
                
                if clicked {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.red)
                        .frame(width: 10, height: 10)
                } else {
                    Spacer()
                        .frame(height: 10)
                }
            }
            .frame(height: 50)
        }
    }
}
