//
//  GochuckView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/24/24.
//

import SwiftUI
import Kingfisher

struct GochuckView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var restaurantViewModel = RestaurantViewModel()
    @State private var selectedFloor = "내야2층"
    @State private var isFavorite = false
    @Namespace private var animation
    
    let stadiumName = "서울 고척야구장"
    let floors = ["내야2층", "내야4층", "외야3층", "외야4층"]
    let floorIds = ["내야2층": "In2F", "내야4층": "In4F", "외야3층": "Out3F", "외야4층": "Out4F"]
    let sportsCategory: SportsCategory = .baseball
    
    private var selectedFloorImage: Image? {
        switch selectedFloor {
        case "내야2층": return Image("Gochuck_In2F")
        case "내야4층": return Image("Gochuck_In4F")
        case "외야3층": return Image("Gochuck_Out3F")
        default: return Image("Gochuck_Out4F")
        }
    }
    
    var body: some View {
        VStack {
            // 층 분류
            HStack {
                ForEach(floors, id: \.self) { floor in
                    Button {
                        selectedFloor = floor
                    } label: {
                        HStack {
                            if selectedFloor == floor {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.black)
                                    .font(.system(size: 12))
                                    .padding(.vertical, 5)
                                    .padding(.trailing, -10)
                                    .bold()
                            }
                            
                            Text(floor)
                                .font(.system(size: 16))
                                .foregroundStyle(selectedFloor == floor ? Color.black : Color.gray)
                                .padding(8)
                        }
                    }
                }
            }
            
            if let selectedImage = selectedFloorImage {
                selectedImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }
            Spacer()
        }
        
//        // 음식 분류
//        FoodCategoryPickerView(selectedCategory: $selectedCategory, animation: animation)
//            .padding()
        
        // 가게 리스트
//        TabView(selection: $selectedCategory) {
//            ForEach(FoodCategory.allCases, id: \.self) { foodCategory in
//                VStack {
//                    List(restaurantViewModel.restaurants.filter { $0.foodCategory == foodCategory.rawValue }) { restaurant in
//                        HStack {
//                            KFImage(URL(string: restaurant.restaurantImageUrl ?? ""))
//                                .resizable()
//                                .frame(width: 50, height: 50)
//                                .cornerRadius(5)
//                            
//                            VStack(alignment: .leading) {
//                                Text(restaurant.name)
//                                    .bold()
//                                    .padding(.bottom, 1)
//                                Text(restaurant.mainMenu)
//                                    .foregroundStyle(.gray)
//                                    .font(.caption)
//                            }
//                        }
//                        
//                    }
//                    .listStyle(.plain)
//                }
//                .onAppear {
//                    restaurantViewModel.fetchRestaurants(for: "Jamsil", floorId: floorIds[selectedFloor] ?? "", floor: selectedFloor, category: foodCategory)
//                }
//            }
//        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
//        .onChange(of: selectedFloor) { _ in
//            restaurantViewModel.fetchRestaurants(for: "Jamsil", floorId: floorIds[selectedFloor] ?? "", floor: selectedFloor, category: selectedCategory)
//        }
        
        .navigationTitle("고척 스카이돔")
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
                        UserDefaults.standard.set(stadiumName, forKey: "favoriteStadium_\(sportsCategory.rawValue)")
                    } else {
                        UserDefaults.standard.removeObject(forKey: "favoriteStadium_\(sportsCategory.rawValue)")
                    }
                } label: {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundStyle(isFavorite ? .yellow : .gray)
                }
            }
        }
        .onAppear {
            // 즐겨찾기 상태 초기화
            isFavorite = UserDefaults.standard.string(forKey: "favoriteStadium_\(sportsCategory.rawValue)") == stadiumName
        }
        .onChange(of: isFavorite) { newValue in // isFavorite 변경 감지
            if newValue {
                UserDefaults.standard.set(stadiumName, forKey: "favoriteStadium_\(sportsCategory.rawValue)")
            } else {
                UserDefaults.standard.removeObject(forKey: "favoriteStadium_\(sportsCategory.rawValue)")
            }
        }
    }
}

