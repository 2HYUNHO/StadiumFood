//
//  MenuItemView.swift
//  StadiumFood
//
//  Created by 이현호 on 6/27/24.
//

import SwiftUI
import Kingfisher

struct MenuItemView: View {
    @State private var isExpanded: Bool = false
    let menuItem: MenuItemModel
    
    var body: some View {
        // 메뉴 리스트
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(menuItem.name)
                        .font(.headline)
                    Text("\(menuItem.price)원")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if !menuItem.subMenu.isEmpty {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundStyle(.gray)
                }
            }
            
            // 세트 메뉴 있을 때
            if isExpanded {
                VStack(alignment: .leading) {
                    ForEach(menuItem.subMenu, id: \.self) { subMenuItem in
                        Text("- \(subMenuItem)")
                            .font(.caption)
                            .padding(.bottom, 1)
                    }
                }
                .padding(.vertical, 5)
                .transition(.opacity)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .onTapGesture {
            withAnimation {
                if !menuItem.subMenu.isEmpty {
                    isExpanded.toggle()
                }
            }
        }
    }
}

