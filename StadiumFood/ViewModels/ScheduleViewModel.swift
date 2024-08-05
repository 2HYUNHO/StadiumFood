//
//  ScheduleViewModel.swift
//  StadiumFood
//
//  Created by 이현호 on 8/3/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import Combine

class ScheduleViewModel: ObservableObject {
    @Published var schedules: [ScheduleModel] = []

    // 비동기 일정 데이터 가져오기
    func fetchSchedules(for date: Date) async {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMdd"  // 날짜를 'MMDD' 형식으로 변환
        let formattedDate = dateFormatter.string(from: date)
        
        do {
            let snapshot = try await Firestore.firestore().collection("schedules")
                .document(formattedDate)
                .collection("stadiums")
                .getDocuments()
            
            DispatchQueue.main.async {
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
        } catch {
            print("Error fetching schedules: \(error.localizedDescription)")
        }
    }
    // 일정 새로 고침 메서드
    func reload(for date: Date) async {
        await fetchSchedules(for: date)
    }
    
    // 날짜와 시간을 포맷하는 메서드
    func formattedDate(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd(EEE) HH:mm"
        return formatter.string(from: date)
    }
    
    // 일정이 있는 구장과 일정이 없는 구장으로 필터링
    func filteredStadiums(from stadiums: [StadiumModel]) -> (withSchedule: [StadiumModel], withoutSchedule: [StadiumModel]) {
        let today = Date()
        
        let stadiumsWithSchedule = stadiums.filter { stadium in
            schedules.contains {
                $0.stadiumName == stadium.name && Calendar.current.isDate($0.date, inSameDayAs: today)
            }
        }
        
        let stadiumsWithoutSchedule = stadiums.filter { stadium in
            !schedules.contains {
                $0.stadiumName == stadium.name && Calendar.current.isDate($0.date, inSameDayAs: today)
            }
        }
        
        return (withSchedule: stadiumsWithSchedule, withoutSchedule: stadiumsWithoutSchedule)
    }
}
