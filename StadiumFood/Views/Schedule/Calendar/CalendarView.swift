//
//  CalendarView.swift
//  StadiumFood
//
//  Created by 이현호 on 8/3/24.
//

import SwiftUI

struct CalendarView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var scheduleViewModel: ScheduleViewModel
    
    @StateObject private var viewModel = CalendarViewModel()
    
    var body: some View {
        VStack {
            headerView
            calendarGridView
            
            if let selectedDate = viewModel.selectedDate {
                CalendarListView(viewModel: scheduleViewModel, date: selectedDate)
            }
            
            Spacer()
        }
        .padding()
        
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
                        .foregroundStyle(.black)
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
                viewModel.changeMonth(by: -1)
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundStyle(viewModel.canMoveToPreviousMonth() ? .black : .gray)
            }
            .disabled(!viewModel.canMoveToPreviousMonth())
            
            Text(viewModel.month, formatter: CalendarViewModel.calendarHeaderDateFormatter)
                .font(.title.bold())
            
            Button {
                viewModel.changeMonth(by: 1)
            } label: {
                Image(systemName: "chevron.right")
                    .font(.title)
                    .foregroundStyle(viewModel.canMoveToNextMonth() ? .black : .gray)
            }
            .disabled(!viewModel.canMoveToNextMonth())
        }
    }
    
    // MARK: - 날짜 그리드 뷰
    private var calendarGridView: some View {
        let daysInMonth: Int = viewModel.numberOfDays(in: viewModel.month)
        let firstWeekday: Int = viewModel.firstWeekdayOfMonth(in: viewModel.month) - 1
        let lastDayOfMonthBefore = viewModel.numberOfDays(in: viewModel.previousMonth())
        let numberOfRows = Int(ceil(Double(daysInMonth + firstWeekday) / 7.0))
        let visibleDaysOfNextMonth = numberOfRows * 7 - (daysInMonth + firstWeekday)
        
        return LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
            ForEach(-firstWeekday ..< daysInMonth + visibleDaysOfNextMonth, id: \.self) { index in
                Group {
                    if index > -1 && index < daysInMonth {
                        let date = viewModel.getDate(for: index)
                        let day = Calendar.current.component(.day, from: date)
                        let clicked = viewModel.selectedDate == date
                        let isToday = date.formattedCalendarDayDate == viewModel.today.formattedCalendarDayDate
                        
                        CellView(day: day, clicked: clicked, isToday: isToday)
                    } else if let prevMonthDate = Calendar.current.date(
                        byAdding: .day,
                        value: index + lastDayOfMonthBefore,
                        to: viewModel.previousMonth()
                    ) {
                        let day = Calendar.current.component(.day, from: prevMonthDate)
                        
                        CellView(day: day, isCurrentMonthDay: false)
                    }
                }
                .onTapGesture {
                    if 0 <= index && index < daysInMonth {
                        let date = viewModel.getDate(for: index)
                        viewModel.selectedDate = date
                        scheduleViewModel.fetchSchedules(for: date)
                    }
                }
            }
        }
    }
    
    private struct CellView: View {
        private var day: Int
        private var clicked: Bool
        private var isToday: Bool
        private var isCurrentMonthDay: Bool
        private var textColor: Color {
            if clicked {
                return Color.white
            } else if isCurrentMonthDay {
                return isToday ? Color.white : Color.black
            } else {
                return Color.gray
            }
        }
        private var backgroundColor: Color {
            if clicked {
                return isToday ? Color.black : Color.gray
            } else if isToday {
                return Color.black
            } else {
                return Color.white
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
