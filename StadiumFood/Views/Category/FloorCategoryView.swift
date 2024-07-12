//
//  FloorCategoryView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/25/24.
//

import SwiftUI

struct FloorCategoryView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedCategory: FloorCategoryModel.FloorCategory
    var animation: Namespace.ID
    var stadium: FloorCategoryModel.Stadium
    
    var body: some View {
        HStack {
            ForEach(stadium.floors, id: \.self) { floorCategory in
                Button {
                    selectedCategory = floorCategory
                } label: {
                    VStack {
                        Text(floorCategory.rawValue)
                            .font(.headline)
                            .foregroundColor(selectedCategory == floorCategory ? (colorScheme == .dark ? .white : .black) : (colorScheme == .dark ? Color(.darkGray) : Color(.lightGray)))
                            .frame(maxWidth: .infinity)
                        if selectedCategory == floorCategory {
                            Capsule()
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "category", in: animation)
                        }
                    }
                }
            }
        }
        Divider()
            .padding(.top, -11)
        
    }
}
