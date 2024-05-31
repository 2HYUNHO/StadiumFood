//
//  SportsCategory.swift
//  StadiumFood
//
//  Created by 이현호 on 5/22/24.
//

import Foundation

// 스포츠 종목
enum SportsCategory: String, CaseIterable {
    case baseball = "야구"
    case soccer = "축구"
    case basketball = "농구"
    case volleyball = "배구"
    
    var imageName: String {
        switch self {
        case .baseball:
            return "Baseball"
        case .soccer:
            return "Soccer"
        case .basketball:
            return "Basketball"
        case .volleyball:
            return "Volleyball"
        }
    }
}
