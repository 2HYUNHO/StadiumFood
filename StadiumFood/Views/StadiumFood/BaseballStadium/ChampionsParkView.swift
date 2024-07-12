//
//  ChampionsParkView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/24/24.
//

import SwiftUI

struct ChampionsParkView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var restaurantViewModel = RestaurantViewModel()
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    @State private var selectedFloor: FloorCategoryModel.FloorCategory = .firstFloor
    @State private var selectedFilter: String? = "전체"
    @State private var isFavorite = false
    @Namespace private var animation
    
    let stadiumId = "ChampionsField"
    let stadiumName = "광주 기아챔피언스필드"
    let floorIds = ["1층": "1F", "2층": "2F", "3층": "3F", "4층": "4F", "5층": "5F"]
    let sportsCategory: SportsCategory = .baseball
    
    var body: some View {
        NavigationView {
            VStack {
                // 층 분류
                FloorCategoryView(selectedCategory: $selectedFloor, animation: animation, stadium: .championsField)
                
                // 가게 리스트
                TabView(selection: $selectedFloor) {
                    ForEach(FloorCategoryModel.Stadium.championsField.floors, id: \.self) { floorCategory in
                        VStack(alignment: .center) {
                            List(restaurantViewModel.restaurants) { restaurant in
                                NavigationLink(destination: MenuInfoView(stadiumId: stadiumId, selectedFloor: selectedFloor, restaurant: restaurant, floorIds: floorIds)) {
                                    RestaurantListView(restaurant: restaurant, selectedLocation: selectedFilter == "전체" ? nil : selectedFilter)
                                }
                            }
                            .listStyle(.plain)
                        }
                        .tag(floorCategory)
                        .onAppear {
                            restaurantViewModel.fetchRestaurants(for: stadiumId, floorId: floorIds[selectedFloor.rawValue] ?? "", floor: selectedFloor.rawValue, locationFilter: selectedFilter == "전체" ? nil : selectedFilter)
                            restaurantViewModel.fetchLocationFilters(for: stadiumId, floorId: floorIds[selectedFloor.rawValue] ?? "", floor: selectedFloor.rawValue)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .onChange(of: selectedFloor) { newFloor in
                    // 선택된 층 변경 시 데이터 다시 가져오기
                    restaurantViewModel.fetchRestaurants(for: stadiumId, floorId: floorIds[newFloor.rawValue] ?? "", floor: selectedFloor.rawValue, locationFilter: selectedFilter == "전체" ? nil : selectedFilter)
                    restaurantViewModel.fetchLocationFilters(for: stadiumId, floorId: floorIds[newFloor.rawValue] ?? "", floor: selectedFloor.rawValue)
                }
            }
        }
        .navigationTitle("광주 기아챔피언스필드")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color(.label))
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isFavorite.toggle()
                    if isFavorite {
                        favoritesViewModel.addFavoriteStadium(stadiumName, category: sportsCategory.rawValue)
                    } else {
                        favoritesViewModel.removeFavoriteStadium(stadiumName, category: sportsCategory.rawValue)
                    }
                } label: {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundStyle(isFavorite ? .yellow : .gray)
                }
            }
        }
        .onAppear {
            // 즐겨찾기 상태 초기화
            isFavorite = favoritesViewModel.favoriteStadiums[sportsCategory.rawValue]?.contains(stadiumName) ?? false
        }
        .onReceive(favoritesViewModel.$favoriteStadiums) { _ in
            // 즐겨찾기 상태가 변경되면 버튼 상태 업데이트
            isFavorite = favoritesViewModel.favoriteStadiums[sportsCategory.rawValue]?.contains(stadiumName) ?? false
        }
    }
}
