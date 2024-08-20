//
//  CalendarViewModel.swift
//  StadiumFood
//
//  Created by 이현호 on 8/3/24.
//

import Foundation
import Firebase
import FirebaseFirestore

class CalendarViewModel: ObservableObject {
    @Published var month: Date = Date()
    @Published var selectedDate: Date?
    @Published var currentDate: Date = Date()
    @Published var dates: [CalendarModel] = []
    @Published var schedules: [ScheduleModel] = []
    
    private var calendar = Calendar.current
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일"
        return formatter
    }
    
    init() {
        updateDates()
    }
    
    func updateDates() {
        dates = []
        for offset in -1...1 {
            if let date = calendar.date(byAdding: .day, value: offset, to: currentDate) {
                dates.append(CalendarModel(date: date))
            }
        }
    }
    
    func updateDates(for newDate: Date) {
        currentDate = newDate
        updateDates()
    }
    
    func goToPreviousDay() {
        if let previousDate = calendar.date(byAdding: .day, value: -1, to: currentDate) {
            currentDate = previousDate
            updateDates()
        }
    }
    
    func goToNextDay() {
        if let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
            currentDate = nextDate
            updateDates()
        }
    }
    
    func formatterDate(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func isSelectedDate(_ date: Date) -> Bool {
        return calendar.isDate(date, inSameDayAs: currentDate)
    }
    
    func selectDate(_ date: Date) {
        currentDate = date
        updateDates()
    }
    
    // 오늘 날짜 반환
    var today: Date {
        let now = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: now)
        return calendar.date(from: components)!
    }
    
    // 날짜를 오늘로 리셋하는 메서드
    func resetToToday() {
        let today = self.today
        self.currentDate = today
        self.selectedDate = today
        updateDates()
    }
    
    // 날짜 포맷터
    static let calendarHeaderDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.MM"
        return formatter
    }()
    
    // 시간 포맷터
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    // 요일 심볼
    static let weekdaySymbols: [String] = Calendar.current.shortWeekdaySymbols
    
    // 특정 날짜 반환
    func getDate(for index: Int) -> Date {
        guard let firstDayOfMonth = calendar.date(
            from: DateComponents(
                year: calendar.component(.year, from: month),
                month: calendar.component(.month, from: month),
                day: 1
            )
        ) else {
            return Date()
        }
        
        var dateComponents = DateComponents()
        dateComponents.day = index
        
        let timeZone = TimeZone.current
        let offset = Double(timeZone.secondsFromGMT(for: firstDayOfMonth))
        dateComponents.second = Int(offset)
        
        let date = calendar.date(byAdding: dateComponents, to: firstDayOfMonth) ?? Date()
        return date
    }
    
    // 해당 월에 존재하는 일자 수 반환
    func numberOfDays(in date: Date) -> Int {
        return calendar.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    // 해당 월의 첫 날짜가 갖는 주의 요일 반환
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = calendar.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = calendar.date(from: components)!
        return calendar.component(.weekday, from: firstDayOfMonth)
    }
    
    // 이전 월의 마지막 일자 반환
    func previousMonth() -> Date {
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month))!
        let previousMonth = calendar.date(byAdding: .month, value: -1, to: firstDayOfMonth)!
        return previousMonth
    }
    
    // 월 변경
    func changeMonth(by value: Int) {
        self.month = adjustedMonth(by: value)
    }
    
    // 이전 월로 이동 가능한지 확인
    func canMoveToPreviousMonth() -> Bool {
        let currentDate = Date()
        let targetDate = calendar.date(byAdding: .month, value: -24, to: currentDate) ?? currentDate
        return adjustedMonth(by: -1) >= targetDate
    }
    
    // 다음 월로 이동 가능한지 확인
    func canMoveToNextMonth() -> Bool {
        let currentDate = Date()
        let targetDate = calendar.date(byAdding: .month, value: 24, to: currentDate) ?? currentDate
        return adjustedMonth(by: 1) <= targetDate
    }
    
    // 변경하려는 월 반환
    private func adjustedMonth(by value: Int) -> Date {
        return calendar.date(byAdding: .month, value: value, to: month) ?? month
    }
    
    // 일정 데이터 가져오기
    func fetchSchedules(for date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMdd"  // 날짜를 'MMDD' 형식으로 변환
        let formattedDate = dateFormatter.string(from: date)
        
        Firestore.firestore().collection("schedules")
            .document(formattedDate)
            .collection("stadiums")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching schedules: \(error.localizedDescription)")
                } else if let snapshot = snapshot {
                    self.schedules = snapshot.documents.compactMap { document -> ScheduleModel? in
                        let data = document.data()
                        let id = document.documentID
                        let away = data["away"] as? String ?? ""
                        let home = data["home"] as? String ?? ""
                        let stadiumName = data["stadiumName"] as? String ?? ""
                        let stadiumImage = data["stadiumImage"] as? String ?? ""
                        let timestamp = data["date"] as? Timestamp ?? Timestamp(date: Date())
                        let date = timestamp.dateValue()
                        
                        return ScheduleModel(id: id, away: away, home: home, stadiumName: stadiumName, stadiumImage: stadiumImage, date: date)
                    }
                }
            }
    }
}
