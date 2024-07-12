//
//  CategoryPickerView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/22/24.
//

import SwiftUI

struct CategoryPickerView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedCategory: SportsCategory
    var animation: Namespace.ID
    
    var body: some View {
        VStack {
            HStack {
                ForEach(SportsCategory.allCases, id: \.self) { sportsCategory in
                    Button {
                        withAnimation(.easeOut) {
                            selectedCategory = sportsCategory
                        }
                    } label: {
                        VStack {
                            HStack {
                                Text(sportsCategory.imageName)
                                    .font(.system(size: 25))
                                    .padding(.leading, 12)
                                    .padding(.trailing, -14)
                                
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
            Divider()
                .padding(.top, -16)
        }
        .padding(.bottom, -20)
    }
}
