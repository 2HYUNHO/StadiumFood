//
//  Notice.swift
//  StadiumFood
//
//  Created by 이현호 on 7/14/24.
//

import Foundation
import Firebase

struct Notice: Identifiable, Codable {
    var id: String?
    let title: String
    let date: Date
    let content: String
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
}
