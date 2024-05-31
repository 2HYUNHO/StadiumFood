//
//  RestaurantViewModel.swift
//  StadiumFood
//
//  Created by 이현호 on 5/30/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class RestaurantViewModel: ObservableObject {
    @Published var restaurants: [RestaurantModel] = []
    
    // 가게정보 가져오기
    func fetchRestaurants(for stadiumId: String, floor: String) {
        Firestore.firestore().collection("stadiums").document(stadiumId).collection(floor).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.restaurants = snapshot?.documents.compactMap { document -> RestaurantModel? in
                    let data = document.data()
                    let name = data["name"] as? String ?? ""
                    let foodCategory = data["foodCategory"] as? String ?? ""
                    let mainMenu = data["mainMenu"] as? String ?? ""
                    let restaurantImageURL = data["restaurantImageURL"] as? String ?? ""
                    return RestaurantModel(name: name, floor: floor, foodCategory: foodCategory, mainMenu: mainMenu, foodInfoView: "", restaurantImageUrl: restaurantImageURL)
                } ?? []
            }
        }
    }
}
