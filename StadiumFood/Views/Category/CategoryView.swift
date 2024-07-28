//
//  categoryView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/22/24.
//

import SwiftUI
import GoogleMobileAds

struct CategoryView: View {
    @State private var selectedCategory: SportsCategory = .baseball
    @Namespace private var animation
    @StateObject var stadiumViewModel = StadiumViewModel()
    
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
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                admob() // 광고
            }
        }
    }
    
    @ViewBuilder
    private func contentView(for sportsCategory: SportsCategory) -> some View {
        switch sportsCategory {
        case .baseball:
            BaseballListView(viewModel: stadiumViewModel)
        case .basketball:
            GenderCategoryView(sportsCategory: sportsCategory)
        case .soccer:
            SoccerListView()
        case .volleyball:
            GenderCategoryView(sportsCategory: sportsCategory)
        }
    }
}
