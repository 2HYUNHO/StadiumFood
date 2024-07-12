//
//  RestaurantListView.swift
//  StadiumFood
//
//  Created by 이현호 on 6/21/24.
//

import SwiftUI
import Kingfisher

struct RestaurantListView: View {
    let restaurant: RestaurantModel
    let selectedLocation: String? // 선택된 위치 필터
    
    var body: some View {
        HStack(spacing: 15) {
            KFImage(URL(string: restaurant.restaurantImageUrl ?? ""))
                .placeholder {
                    Image(systemName: "photo")
                        .resizable()
                }
                .resizable()
                .frame(width: 70, height: 70)
                .cornerRadius(5)
            
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text(restaurant.name)
                        .bold()
                        .padding(.bottom, 5)
                    
                    if let selectedLocation = selectedLocation {
                        if restaurant.location.contains(selectedLocation) {
                            Text(selectedLocation)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                    } else {
                        Text(restaurant.location.joined(separator: ", "))
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                }
                
                Text(restaurant.foodCategory)
                    .font(.caption)
            }
            .padding(.vertical, 15)
            
            Spacer()
        }
    }
}
