//
//  MenuItemViewModel.swift
//  StadiumFood
//
//  Created by 이현호 on 5/30/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class MenuItemViewModel: ObservableObject {
    @Published var menuItems: [MenuItemModel] = []
    private var db = Firestore.firestore()
    
    init(stadiumId: String, restaurantId: String) {
        fetchMenuItems(stadiumId: stadiumId, restaurantId: restaurantId)
    }
    
    func fetchMenuItems(stadiumId: String, restaurantId: String) {
        db.collection("stadiums").document(stadiumId).collection("restaurants").document(restaurantId).collection("menuItems").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.menuItems = querySnapshot?.documents.compactMap { (queryDocumentSnapshot) -> MenuItemModel? in
                    return try? queryDocumentSnapshot.data(as: MenuItemModel.self)
                } ?? []
            }
        }
    }
}
