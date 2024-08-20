//
//  Stadiums.swift
//  StadiumFood
//
//  Created by 이현호 on 6/27/24.
//

import Foundation
import SwiftUI

enum StadiumEnum: String, CaseIterable {
    case jamsil = "Jamsil"
    case gochuck = "Gochuck"
    case wizPark = "KTwiz"
    case landersField = "LandersField"
    case eaglesPark = "EaglesPark"
    case lionsPark = "LionsPark"
    case championsField = "ChampionsField"
    case ncPark = "NCPark"
    case sajic = "Sajic"
    
    // 구장 식별자
    var id: String {
        return self.rawValue
    }
    
    // 구장이름
    var name: String {
        switch self {
        case .jamsil:
            return "서울 잠실야구장"
        case .gochuck:
            return "서울 고척스카이돔"
        case .wizPark:
            return "수원 KT위즈파크"
        case .landersField:
            return "인천 SSG랜더스필드"
        case .eaglesPark:
            return "대전 한화이글스파크"
        case .lionsPark:
            return "대구 삼성라이온즈파크"
        case .championsField:
            return "광주 기아챔피언스필드"
        case .ncPark:
            return "창원 NC파크"
        case .sajic:
            return "부산 사직야구장"
        }
    }
    
    // 구장별 층 목록
    var floors: [String: String] {
        switch self {
        case .jamsil:
            return ["1층": "1F", "2층": "2F", "3층": "3F", "4층" : "4F"]
        case .gochuck:
            return ["2층": "2F", "3층": "3F", "4층": "4F"]
        case .wizPark:
            return ["2층 상단": "2F TOP", "2층 하단": "2F BOTTOM"]
        case .landersField:
            return ["B1층": "B1F", "1층": "1F", "2층": "2F", "4층": "4F"]
        case .lionsPark:
            return ["1층": "1F", "2층": "2F", "3층": "3F", "5층": "5F"]
        case .ncPark:
            return ["1층": "1F", "2층": "2F"]
        case .sajic:
            return ["1층": "1F", "2층": "2F", "3층": "3F", "4층": "4F"]
        case .eaglesPark:
            return ["1루": "1B", "중앙": "C", "3루": "3B"]
        case .championsField:
            return ["1층": "1F", "2층": "2F", "3층": "3F", "4층": "4F", "5층": "5F"]
        }
    }
    
    var sportsCategory: SportsCategory {
        return .baseball
    }
}
