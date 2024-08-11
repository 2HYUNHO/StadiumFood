//
//  HomeCategoryView.swift
//  StadiumFood
//
//  Created by 이현호 on 8/2/24.
//

import SwiftUI

struct HomeCategoryView: View {
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
                                .foregroundStyle(selectedCategory == homeCategory ? .white : Color(uiColor: .systemGray3))
                                .fontWeight(selectedCategory == homeCategory ? .heavy : .semibold)
                                .frame(maxWidth: .infinity)
                            if selectedCategory == homeCategory {
                                Capsule()
                                    .foregroundStyle(.white)
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
        .scrollDisabled(true)
        .padding(.horizontal)
        .padding(.top, 10)
        .padding(.bottom, 5)
    }
}
