//
//  Schedule.swift
//  StadiumFood
//
//  Created by LHH on 8/5/24.
//

import Foundation

struct ScheduleModel: Identifiable, Codable {
    var id: String?
    let away: String
    let home: String
    let stadiumName: String
    let stadiumImage: String
    let date: Date
}
