//
//  StadiumView.swift
//  StadiumFood
//
//  Created by 이현호 on 7/10/24.
//

import SwiftUI

struct StadiumView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var restaurantViewModel = RestaurantViewModel()
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    @State var selectedFloor: FloorCategoryModel.FloorCategory
    @State private var isFavorite = false
    @State private var selectedFilter: String? = "전체"
    var animation: Namespace.ID
    let stadiumId: String
    let stadiumName: String
    let floorIds: [String: String]
    let sportsCategory: SportsCategory
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // 층 분류
                FloorCategoryView(selectedCategory: $selectedFloor, animation: animation, stadium: getStadiumEnum(stadiumId))
                
                // 위치 필터
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(restaurantViewModel.locationFilters, id: \.self) { filter in
                            Button {
                                // 버튼 액션 추가
                                selectedFilter = filter
                                restaurantViewModel.fetchRestaurants(for: stadiumId, floorId: floorIds[selectedFloor.rawValue] ?? "", floor: selectedFloor.rawValue, locationFilter: filter == "전체" ? nil : filter)
                                
                                print("\(filter) 버튼이 눌렸습니다.")
                            } label: {
                                Capsule()
                                    .fill(selectedFilter == filter ? Color.green : Color(uiColor: .systemGray3))
                                    .frame(width: 65, height: 30)
                                    .overlay(
                                        Text(filter)
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.white)
                                    )
                                
                            }
                        }
                        .padding(.horizontal, 5)
                    }
                    .padding(.leading)
                }
                
                // 가게 리스트
                TabView(selection: $selectedFloor) {
                    ForEach(getStadiumEnum(stadiumId).floors, id: \.self) { floorCategory in
                        VStack {
                            if restaurantViewModel.restaurants.isEmpty {
                                Text("메뉴 정보가 없습니다.")
                                    .foregroundStyle(.gray)
                            } else {
                                List(restaurantViewModel.restaurants) { restaurant in
                                    NavigationLink(destination: MenuInfoView(stadiumId: stadiumId, selectedFloor: selectedFloor, restaurant: restaurant, floorIds: floorIds)) {
                                        RestaurantListView(restaurant: restaurant, selectedLocation: selectedFilter == "전체" ? nil : selectedFilter)
                                    }
                                }
                                .listStyle(.plain)
                            }
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
                    restaurantViewModel.fetchRestaurants(for: stadiumId, floorId: floorIds[newFloor.rawValue] ?? "", floor: newFloor.rawValue, locationFilter: selectedFilter == "전체" ? nil : selectedFilter)
                    restaurantViewModel.fetchLocationFilters(for: stadiumId, floorId: floorIds[newFloor.rawValue] ?? "", floor: newFloor.rawValue)
                }
            }
            .navigationBarTitle(stadiumName, displayMode: .inline)
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
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            // 즐겨찾기 상태 초기화
            isFavorite = favoritesViewModel.favoriteStadiums[sportsCategory.rawValue]?.contains(stadiumName) ?? false
        }
        .onReceive(favoritesViewModel.$favoriteStadiums) { _ in
            // 즐겨찾기 상태가 변경되면 버튼 상태 업데이트
            isFavorite = favoritesViewModel.favoriteStadiums[sportsCategory.rawValue]?.contains(stadiumName) ?? false
        }
    }
    
    private func getStadiumEnum(_ stadiumId: String) -> FloorCategoryModel.Stadium {
        switch stadiumId {
        case "Jamsil":
            return .jamsil
        case "KTwiz":
            return .wizPark
        case "LandersField":
            return .landersField
        case "NCPark":
            return .ncPark
        default:
            return .jamsil
        }
    }
}
