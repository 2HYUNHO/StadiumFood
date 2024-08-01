//
//  HomeCategoryView.swift
//  StadiumFood
//
//  Created by 이현호 on 8/2/24.
//

import SwiftUI

struct HomeCategoryView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedCategory: HomeCategory
    var animation: Namespace.ID
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(HomeCategory.allCases, id: \.self) { homeCategory in
                    Button {
                        withAnimation(.easeOut) {
                            selectedCategory = homeCategory
                        }
                    } label: {
                        VStack {
                            Text(homeCategory.rawValue)
                                .font(.headline)
                                .foregroundColor(selectedCategory == homeCategory ? (colorScheme == .dark ? .white : .black) : (colorScheme == .dark ? Color(.darkGray) : Color(.lightGray)))
                                .frame(maxWidth: .infinity)
                            if selectedCategory == homeCategory {
                                Capsule()
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    .frame(height: 2)
                                    .matchedGeometryEffect(id: "category", in: animation)
                            }
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 5)
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}
