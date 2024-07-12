//
//  StadiumModel.swift
//  StadiumFood
//
//  Created by 이현호 on 5/22/24.
//

import Foundation
import FirebaseFirestoreSwift

// 구장 모델
struct StadiumModel: Identifiable, Codable {
    var id: String?
    let name: String
    let imageURL: String
    let teams: [String]
    let destinationView: String
    let order: Int
    let restaurants: [RestaurantModel]
    let floors: [String]
}
