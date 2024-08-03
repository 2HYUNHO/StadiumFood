//
//  ScheduleViewModel.swift
//  StadiumFood
//
//  Created by 이현호 on 8/3/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class ScheduleViewModel: ObservableObject {
    @Published var schedules: [ScheduleModel] = []
    
    func fetchSchedules(for date: Date) {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        Firestore.firestore().collection("schedules")
            .whereField("date", isGreaterThanOrEqualTo: startOfDay)
            .whereField("date", isLessThan: endOfDay)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching schedules: \(error.localizedDescription)")
                } else if let snapshot = snapshot {
                    self.schedules = snapshot.documents.compactMap { document -> ScheduleModel? in
                        let data = document.data()
                        let id = document.documentID
                        let away = data["away"] as? String ?? ""
                        let home = data["home"] as? String ?? ""
                        let stadium = data["stadium"] as? String ?? ""
                        let stadiumImage = data["stadiumImage"] as? String ?? ""
                        let timestamp = data["date"] as? Timestamp ?? Timestamp(date: Date())
                        let date = timestamp.dateValue()
                        
                        return ScheduleModel(id: id, away: away, home: home, stadium: stadium, stadiumImage: stadiumImage, date: date)
                    }
                }
            }
    }
    
    // 날짜와 시간을 포맷하는 메서드
    func formattedDate(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd(EEE) HH:mm"
        return formatter.string(from: date)
    }
}
