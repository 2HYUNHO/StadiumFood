//
//  FoodCategoryPicker.swift
//  StadiumFood
//
//  Created by 이현호 on 5/25/24.
//

import SwiftUI

struct FoodCategoryPickerView: View {
    @Binding var selectedCategory: FoodCategory
    var animation: Namespace.ID
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            ForEach(FoodCategory.allCases, id: \.self) { foodCategory in
                Button {
                    withAnimation(.easeOut) {
                        selectedCategory = foodCategory
                    }
                } label: {
                    VStack {
                        Text(foodCategory.rawValue)
                            .font(.headline)
                            .foregroundColor(selectedCategory == foodCategory ? (colorScheme == .dark ? .white : .black) : (colorScheme == .dark ? Color(.darkGray) : Color(.lightGray)))
                        if selectedCategory == foodCategory {
                            Capsule()
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "category", in: animation)
                        }
                    }
                }
            }
        }
    }
}
