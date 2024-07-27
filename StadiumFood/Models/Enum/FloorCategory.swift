//
//  FloorCategory.swift
//  StadiumFood
//
//  Created by 이현호 on 6/19/24.
//

import Foundation

// 층을 나타내는 열거형
struct FloorCategoryModel {
    
    // 야구장을 구분하는 enum
    enum Stadium: String, CaseIterable {
        case jamsil = "잠실 야구장"
        case gochuck = "고척 야구장"
        case wizPark = "수원 KT위즈파크"
        case landersField = "인천 SSG랜더스필드"
        case championsField = "광주 기아챔피언스필드"
        case ncPark = "창원 NC파크"
        case eaglesPark = "대전 한화이글스파크"
        case lionsPark = "대구 삼성라이온즈파크"
        case sajic = "부산 사직야구장"
        
        var floors: [FloorCategory] {
            switch self {
            case .jamsil:
                return [.firstFloor, .secondFloor, .thirdFloor, .fourthFloor]
            case .gochuck:
                return [.secondFloor, .thirdFloor, .fourthFloor]
            case .wizPark:
                return [.wizParkTopOfSecondFloor, .wizParkBottomOfSecondFloor]
            case .landersField:
                return [.basementFirstFloor, .firstFloor, .secondFloor, .fourthFloor]
            case .lionsPark:
                return [.firstFloor, .secondFloor, .thirdFloor, .fifthFloor]
            case .ncPark:
                return [.firstFloor, .secondFloor]
            case .eaglesPark:
                return [.firstBase, .centerBase, .thirdBase]
            case .sajic:
                return [.firstFloor, .secondFloor, .thirdFloor, .fourthFloor]
            case .championsField:
                return [.firstFloor, .secondFloor, .thirdFloor, .fourthFloor, .fifthFloor]
            }
        }
    }
    
    // 층을 나타내는 enum
    enum FloorCategory: String, CaseIterable {
        // 야구장의 층
        case basementFirstFloor = "B1층"
        case firstFloor = "1층"
        case secondFloor = "2층"
        case thirdFloor = "3층"
        case fourthFloor = "4층"
        case fifthFloor = "5층"
        case firstBase = "1루"
        case centerBase = "중앙"
        case thirdBase = "3루"
        
        // 수원 KTWiz파크의 층
        case wizParkTopOfSecondFloor = "2층 상단"
        case wizParkBottomOfSecondFloor = "2층 하단"
        
        var name: String {
            rawValue
        }
    }
}

