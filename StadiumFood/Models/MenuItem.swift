//
//  MenuItemModel.swift
//  StadiumFood
//
//  Created by 이현호 on 5/22/24.
//

import Foundation
import FirebaseFirestoreSwift

// 메뉴 아이템 모델
struct MenuItemModel: Identifiable, Codable  {
    var id: String?
    let name: String                    // 음식이름
    let price: Int                      // 음식가격
    let subMenu: [String]
    let order: Int
}
