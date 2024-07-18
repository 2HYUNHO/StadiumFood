//
//  MenuItemViewModel.swift
//  StadiumFood
//
//  Created by 이현호 on 5/30/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class MenuItemViewModel: ObservableObject {
    @Published var menuItems: [MenuItemModel] = []
    
    // 메뉴정보 가져오기
    func fetchMenuItems(stadiumId: String, floorId: String, restaurantId: String) {
        Firestore.firestore().collection("stadiums").document(stadiumId)
            .collection(floorId).document(restaurantId)
            .collection("menuItem")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    self.menuItems = snapshot?.documents.compactMap { document -> MenuItemModel? in
                        let data = document.data()
                        let id = document.documentID
                        let name = data["name"] as? String ?? ""
                        let price = data["price"] as? Int ?? 0
                        let subMenu = data["subMenu"] as? [String] ?? []
                        let order = data["order"] as? Int ?? Int.max
                        
                        return MenuItemModel(id: id, name: name, price: price, subMenu: subMenu, order: order)
                    } ?? []
                    
                    // order 값을 기준으로 정렬
                    self.menuItems.sort { $0.order < $1.order }
                }
            }
    }
}
