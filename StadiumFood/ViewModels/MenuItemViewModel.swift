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
    @Published var menuFilters: [String] = ["전체"] // 필터 초기값 "전체"
    
    // 메뉴정보 가져오기
    func fetchMenuItems(stadiumId: String, floorId: String, restaurantId: String, menuFilter: String?) {
        var query: Query = Firestore.firestore().collection("stadiums").document(stadiumId)
            .collection(floorId).document(restaurantId)
            .collection("menuItem")
        
        if let menuFilter = menuFilter, menuFilter != "전체" {
            query = query.whereField("category", isEqualTo: menuFilter)
        }
        
        query.getDocuments { snapshot, error in
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
                    let category = data["category"] as? String ?? ""
                    
                    return MenuItemModel(id: id, name: name, price: price, subMenu: subMenu, order: order, category: category)
                } ?? []
                
                // order 값을 기준으로 정렬
                self.menuItems.sort { $0.order < $1.order }
            }
        }
    }
    
    // 메뉴 필터 목록을 가져오는 메서드
    func fetchMenuFilters(for stadiumId: String, floorId: String, restaurantId: String) {
        Firestore.firestore().collection("stadiums").document(stadiumId)
            .collection(floorId).document(restaurantId)
            .collection("menuItem")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("문서를 가져오는 중 오류 발생: \(error)")
                } else {
                    var filters: Set<String> = ["전체"]
                    
                    for document in snapshot?.documents ?? [] {
                        let data = document.data()
                        if let category = data["category"] as? String {
                            filters.insert(category)
                        }
                    }
                    
                    // 필터 목록을 고정
                    let fixedOrder: [String] = ["전체", "메인메뉴", "서브메뉴", "음료"]
                    self.menuFilters = fixedOrder.filter { filters.contains($0) }
                }
            }
    }
}
