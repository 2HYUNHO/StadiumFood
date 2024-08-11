//
//  FloorsCategoryView.swift
//  StadiumFood
//
//  Created by 이현호 on 7/10/24.
//

import SwiftUI

struct FloorsCategoryView: View {
    @Binding var selectedCategory: String
    var animation: Namespace.ID
    var stadium: StadiumModel // StadiumModel에서 필요한 속성들을 가져와야 함
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(stadium.floors, id: \.self) { floor in
                    Button {
                        selectedCategory = floor
                    } label: {
                        VStack {
                            Text(floor)
                                .font(.headline)
                                .foregroundStyle(selectedCategory == floor ? .black : .gray)
                                .frame(maxWidth: .infinity)
                            if selectedCategory == floor {
                                Capsule()
                                    .foregroundStyle(.black)
                                    .frame(height: 2)
                                    .matchedGeometryEffect(id: "category", in: animation)
                            }
                        }
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(Color.secondary.opacity(selectedCategory == floor ? 0.2 : 0))
                    .cornerRadius(10)
                }
            }
            .padding(.horizontal)
        }
        .background(Color.primary.opacity(0.1))
        .cornerRadius(15)
        .padding(.horizontal)
        .padding(.top, 10)
    }
}
