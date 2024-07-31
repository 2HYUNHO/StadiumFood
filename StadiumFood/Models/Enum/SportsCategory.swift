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
    
    var imageName: String {
        switch self {
        case .baseball:
            return "⚾️"
        }
    }
}
