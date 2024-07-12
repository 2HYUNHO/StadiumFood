//
//  MenuItemView.swift
//  StadiumFood
//
//  Created by 이현호 on 6/27/24.
//

import SwiftUI
import Kingfisher

struct MenuItemView: View {
    let menuItem: MenuItemModel
    
    var body: some View {
        // 메뉴 리스트
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(menuItem.name)
                    .font(.headline)
                Text("\(menuItem.price)원")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // 세트 메뉴 있을 때
//            VStack {
//                Group {
//                    Text("불고기버거")
//                    Text("통오징어링")
//                    Text("치즈스틱")
//                    Text("콜라L")
//                }
//                .font(.caption)
//                .foregroundStyle(.gray)
//            }
            
//            KFImage(URL(string: menuItem.menuImageURL))
//                .resizable()
//                .frame(width: 80, height: 50)
//                .cornerRadius(8)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

