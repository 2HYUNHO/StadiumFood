//
//  JamsilView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/24/24.
//

import SwiftUI

struct JamsilView: View {
    @StateObject private var restaurantViewModel = RestaurantViewModel()
    @State private var selectedFloor = "1층"
    @State private var selectedCategory: FoodCategory = .cafe
    @Namespace private var animation
    
    let floors = ["1층", "2층", "3/4층"]
    
    var selectedFloorImage: Image? {
        switch selectedFloor {
        case "1층": return Image("Jamsil_Info_1F")
        case "2층": return Image("Jamsil_Info_2F")
        default: return Image("Jamsil_Info_3_4F")
        }
    }
    
    var body: some View {
        VStack {
            Picker("Floor", selection: $selectedFloor) {
                ForEach(floors, id: \.self) { floor in
                    Text(floor)
                }
            }
            .accentColor(.black)
            .pickerStyle(MenuPickerStyle())
            
            if let selectedImage = selectedFloorImage {
                selectedImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }
            
            Spacer()
            
            FoodCategoryPickerView(selectedCategory: $selectedCategory, animation: animation)
                .padding()
            
            TabView(selection: $selectedCategory) {
                ForEach(FoodCategory.allCases, id: \.self) { foodCategory in
                    VStack {
                        List(restaurantViewModel.restaurants) { restaurant in
                            HStack {
                                Image(systemName: "photo")
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(5)
                                
                                VStack(alignment: .leading) {
                                    Text(restaurant.name)
                                    Text("Main Menu: \(restaurant.mainMenu)")
                                }
                            }
                            
                        }
                        .listStyle(.plain)
                        .onAppear {
                            restaurantViewModel.fetchRestaurants(for: "Jamsil", floor: selectedFloor)
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        }
        .navigationTitle("서울 잠실야구장")
        
    }
}

