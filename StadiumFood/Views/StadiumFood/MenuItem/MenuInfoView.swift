//
//  MenuInfoView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/25/24.
//

import SwiftUI
import Kingfisher

struct MenuInfoView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var menuItemViewModel = MenuItemViewModel()
    
    let stadiumId: String
    let selectedFloor: FloorCategoryModel.FloorCategory
    let restaurant: RestaurantModel
    let floorIds: [String: String]
    
    var body: some View {
        VStack {
            Divider()
                .padding(.horizontal)
            
            // 메뉴 리스트 표시
            if restaurant.foodCategory == "편의점" {
                Spacer()
                
                Text("편의점은 메뉴를 제공하지 않습니다.")
                    .foregroundStyle(.gray)
                    .font(.system(size: 18))
                    .padding()
                
            } else if menuItemViewModel.menuItems.isEmpty {
                Text("메뉴 정보가 없습니다.")
                    .foregroundStyle(.gray)
                    .padding()
                
            } else {
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(menuItemViewModel.menuItems) { menuItem in
                            MenuItemView(menuItem: menuItem)
                        }
                    }
                    .padding()
                }
            }
            Spacer()
        }
        .navigationBarTitle(restaurant.name, displayMode: .inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 16))
                        .foregroundStyle(Color(.label))
                }
            }
        }
        .onAppear {
            if let restaurantId = restaurant.id {
                menuItemViewModel.fetchMenuItems(stadiumId: stadiumId, floorId: floorIds[selectedFloor.rawValue] ?? "", restaurantId: restaurantId)
            } else {
                print("Restaurant id is nil")
            }
        }
    }
}
