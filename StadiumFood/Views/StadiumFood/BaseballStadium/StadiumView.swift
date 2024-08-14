//
//  StadiumView.swift
//  StadiumFood
//
//  Created by 이현호 on 7/10/24.
//

import SwiftUI

struct StadiumView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var restaurantViewModel = RestaurantViewModel()
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    @State var selectedFloor: FloorCategoryModel.FloorCategory
    @State private var selectedFilter: String? = "전체"
    var animation: Namespace.ID
    let stadiumId: String
    let stadiumName: String
    let floorIds: [String: String]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // 층 분류
                FloorCategoryView(selectedCategory: $selectedFloor, animation: animation, stadium: getStadium(from: stadiumId))
                
                // 위치 필터
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(restaurantViewModel.locationFilters, id: \.self) { filter in
                            Button {
                                selectedFilter = filter
                                restaurantViewModel.fetchRestaurants(for: stadiumId, floorId: floorIds[selectedFloor.rawValue] ?? "", floor: selectedFloor.rawValue, locationFilter: filter == "전체" ? nil : filter)
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
                .scrollDisabled(true)
                
                // 가게 리스트
                TabView(selection: $selectedFloor) {
                    ForEach(getStadium(from: stadiumId).floors, id: \.self) { floorCategory in
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
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onChange(of: selectedFloor) { newFloor in
                    selectedFilter = "전체"
                    // 선택된 층 변경 시 데이터 다시 가져오기
                    restaurantViewModel.fetchRestaurants(for: stadiumId, floorId: floorIds[newFloor.rawValue] ?? "", floor: newFloor.rawValue, locationFilter: nil)
                    restaurantViewModel.fetchLocationFilters(for: stadiumId, floorId: floorIds[newFloor.rawValue] ?? "", floor: newFloor.rawValue)
                }
            }
            .navigationBarTitle(stadiumName, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 16))
                            .foregroundStyle(.black)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if favoritesViewModel.favoriteStadiums.contains(stadiumName) {
                            favoritesViewModel.removeFavoriteStadium(stadiumName)
                        } else {
                            favoritesViewModel.addFavoriteStadium(stadiumName)
                        }
                    } label: {
                        Image(systemName: favoritesViewModel.favoriteStadiums.contains(stadiumName) ? "star.fill" : "star")
                            .foregroundStyle(favoritesViewModel.favoriteStadiums.contains(stadiumName) ? .black : .gray)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    private func getStadium(from stadiumId: String) -> FloorCategoryModel.Stadium {
        guard let stadiumEnum = StadiumEnum(rawValue: stadiumId) else {
            return .jamsil // 기본값을 설정
        }
        
        switch stadiumEnum {
        case .jamsil:
            return .jamsil
        case .gochuck:
            return .gochuck
        case .wizPark:
            return .wizPark
        case .landersField:
            return .landersField
        case .eaglesPark:
            return .eaglesPark
        case .lionsPark:
            return .lionsPark
        case .championsField:
            return .championsField
        case .ncPark:
            return .ncPark
        case .sajic:
            return .sajic
        }
    }
}
