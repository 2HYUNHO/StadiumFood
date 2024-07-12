//
//  FloorCategory.swift
//  StadiumFood
//
//  Created by 이현호 on 6/19/24.
//

import Foundation

struct FloorCategoryModel {
    
    // 야구장을 구분하는 enum
    enum Stadium: String, CaseIterable {
        case jamsil = "잠실 야구장"
        case gocheok = "고척 야구장"
        case wizPark = "수원 KT위즈파크"
        case landersField = "인천 SSG랜더스필드"
        case championsField = "광주 기아챔피언스필드"
        
        var floors: [FloorCategory] {
            switch self {
            case .jamsil:
                return [.firstFloor, .secondFloor, .jamsilThirdFourthFloor]
            case .gocheok:
                return [.gocheokInfieldSecondFloor, .gocheokInfieldFourthFloor, .gocheokOutfieldThirdFloor, .gocheokOutfieldFourthFloor]
            case .wizPark:
                return [.firstFloor, .wizParkTopOfSecondFloor, .thirdFloor]
            case .landersField:
                return [.firstFloor, .secondFloor, .thirdFloor]
            case .championsField:
                return [.firstFloor, .secondFloor, .thirdFloor, .fourthFloor, .fifthFloor]
            }
        }
    }
    
    // 층을 나타내는 enum
    enum FloorCategory: String, CaseIterable {
        // 야구장의 층
        case firstFloor = "1층"
        case secondFloor = "2층"
        case thirdFloor = "3층"
        case fourthFloor = "4층"
        case fifthFloor = "5층"
        
        // 잠실 야구장의 층
        case jamsilThirdFourthFloor = "3/4층"
        
        // 고척 야구장의 층
        case gocheokInfieldSecondFloor = "내야2층"
        case gocheokInfieldFourthFloor = "내야4층"
        case gocheokOutfieldThirdFloor = "외야3층"
        case gocheokOutfieldFourthFloor = "외야4층"
        
        // 수원 KTWiz파크의 층
        case wizParkTopOfSecondFloor = "2층 상단"
        
        var stadium: Stadium {
            switch self {
            case .firstFloor, .secondFloor, .jamsilThirdFourthFloor:
                return .jamsil
            case .gocheokInfieldSecondFloor, .gocheokInfieldFourthFloor, .gocheokOutfieldThirdFloor, .gocheokOutfieldFourthFloor:
                return .gocheok
            case .thirdFloor, .fourthFloor, .fifthFloor:
                return .championsField
            case .wizParkTopOfSecondFloor:
                return .wizPark
            }
        }
        var name: String {
            rawValue
        }
    }
}


