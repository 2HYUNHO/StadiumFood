//
//   FoodCategory.swift
//  StadiumFood
//
//  Created by 이현호 on 5/25/24.
//

import Foundation

// 메뉴 카테고리
enum FoodCategory: String, CaseIterable {
    case cafe = "카페"
    case chicken = "치킨"
    case pizza = "피자"
    case snackBar = "스낵"
    case fastFood = "패스트푸드"
    case convenienceStore = "편의점"
    case etc = "기타"
}
