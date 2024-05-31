//
//  categoryView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/22/24.
//

import SwiftUI

struct CategoryView: View {
    @State private var selectedCategory: SportsCategory = .baseball
    @Namespace private var animation
    
    var body: some View {
        NavigationView {
            VStack {
                CategoryPickerView(selectedCategory: $selectedCategory, animation: animation)
                TabView(selection: $selectedCategory) {
                    ForEach(SportsCategory.allCases, id: \.self) { sportsCategory in
                        contentView(for: sportsCategory)
                            .tag(sportsCategory)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
            }
        }
    }
    
    private func contentView(for sportsCategory: SportsCategory) -> some View {
        let stadiumViewModel = StadiumViewModel() // 임의의 값으로 StadiumViewModel 생성
        return CategoryContentView(stadiumViewModel: stadiumViewModel, sportsCategory: sportsCategory)
            .transition(.opacity) // 콘텐츠 전환 애니메이션 추가 (선택적)
    }
}
