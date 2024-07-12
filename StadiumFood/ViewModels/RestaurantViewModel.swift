//
//  RestaurantViewModel.swift
//  StadiumFood
//
//  Created by 이현호 on 5/30/24.
//

import SwiftUI
import FirebaseFirestore

class RestaurantViewModel: ObservableObject {
    @Published var restaurants: [RestaurantModel] = []
    @Published var locationFilters: [String] = ["전체"] // 초기값 "전체"

    // Firestore에서 가게 정보를 가져오는 메서드
    func fetchRestaurants(for stadiumId: String, floorId: String, floor: String, locationFilter: String?) {
        var query: Query = Firestore.firestore().collection("stadiums").document(stadiumId).collection(floorId)
            .whereField("floor", isEqualTo: floor)
        
        if let locationFilter = locationFilter, locationFilter != "전체" {
            query = query.whereField("location", arrayContains: locationFilter)
        }
        
        query.getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.restaurants = snapshot?.documents.compactMap { document -> RestaurantModel? in
                    let data = document.data()
                    let id = document.documentID
                    let name = data["name"] as? String ?? ""
                    let foodCategory = data["foodCategory"] as? String ?? ""
                    let restaurantImageURL = data["restaurantImageURL"] as? String ?? ""
                    let location = data["location"] as? [String] ?? []
                    
                    return RestaurantModel(id: id, name: name, floor: floor, foodCategory: foodCategory, restaurantImageUrl: restaurantImageURL, location: location)
                } ?? []
            }
        }
    }
    
    // 위치 필터 목록을 가져오는 메서드
    func fetchLocationFilters(for stadiumId: String, floorId: String, floor: String) {
        Firestore.firestore().collection("stadiums").document(stadiumId).collection(floorId)
            .whereField("floor", isEqualTo: floor)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("문서를 가져오는 중 오류 발생: \(error)")
                } else {
                    var filters: [String] = []
                    
                    for document in snapshot?.documents ?? [] {
                        let data = document.data()
                        if let locations = data["location"] as? [String] {
                            filters.append(contentsOf: locations)
                        }
                    }
                    
                    // 중복 제거 후 "전체"를 포함하여 위치 필터 설정
                    self.locationFilters = ["전체"] + Array(Set(filters)).sorted()
                }
            }
    }
}
