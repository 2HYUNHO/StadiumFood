//
//  Stadiums.swift
//  StadiumFood
//
//  Created by 이현호 on 6/27/24.
//

import Foundation
import SwiftUI

enum StadiumEnum: String, CaseIterable {
    case jamsil
    case gochuck
    case wizPark
    case landersField
    case eaglesPark
    case lionsPark
    case championsPark
    case ncPark
    case sajic
    
    // 구장 식별자
    var id: String {
        return self.rawValue.capitalized
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
        case .championsPark:
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
        case .jamsil, .gochuck:
            return ["1층": "1F", "2층": "2F", "3/4층": "3F"]
        case .wizPark, .landersField, .eaglesPark, .lionsPark, .championsPark, .ncPark, .sajic:
            return ["1층": "1F", "2층": "2F", "3층": "3F"]
        }
    }
    
    var sportsCategory: SportsCategory {
        switch self {
        case .jamsil, .gochuck, .wizPark, .landersField, .eaglesPark, .lionsPark, .championsPark, .ncPark, .sajic:
            return .baseball
        }
    }
}
