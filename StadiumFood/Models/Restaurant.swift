//
//  RestaurantModel.swift
//  StadiumFood
//
//  Created by 이현호 on 5/22/24.
//

import Foundation
import FirebaseFirestoreSwift

// 식당 모델
struct RestaurantModel: Identifiable, Codable {
    var id: String?
    let name: String                    // 가게이름
    let floor: String                   // 구장 층
    let foodCategory: String            // 음식카테고리
    let mainMenu: String                // 주요 메뉴
    let foodInfoView: String?           // 음식정보 뷰 경로
    let restaurantImageUrl: String?     // 가게사진
}
