//
//  CategoryPickerView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/22/24.
//

import SwiftUI

struct CategoryPickerView: View {
    @Binding var selectedCategory: SportsCategory
    var animation: Namespace.ID
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            ForEach(SportsCategory.allCases, id: \.self) { sportsCategory in
                Button {
                    withAnimation(.easeOut) {
                        selectedCategory = sportsCategory
                    }
                } label: {
                    VStack {
                        HStack {
                            Image(sportsCategory.imageName)
                                .resizable()
                                .frame(width: 25, height: 25)
                                .clipShape(Circle())
                                .padding(.leading, 12)
                                .padding(.trailing, -10)
                            Text(sportsCategory.rawValue)
                                .font(.title3)
                                .frame(maxWidth: .infinity/4, maxHeight: 50)
                                .foregroundColor(selectedCategory == sportsCategory ? (colorScheme == .dark ? .white : .black) : (colorScheme == .dark ? Color(.darkGray) : Color(.lightGray)))
                        }
                        if selectedCategory == sportsCategory {
                            Capsule()
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .frame(height: 3)
                                .matchedGeometryEffect(id: "category", in: animation)
                        }
                    }
                }
            }
        }
    }
}
