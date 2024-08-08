//
//  HomeView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/22/24.
//

import SwiftUI
import GoogleMobileAds

struct HomeView: View {
    @StateObject var stadiumViewModel = StadiumViewModel()
    @StateObject var scheduleViewModel = ScheduleViewModel()
    @StateObject var favoritesViewModel = FavoritesViewModel()
    @Namespace private var animation
    @State private var selectedCategory: HomeCategory = .all
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            VStack {
                HomeCategoryView(selectedCategory: $selectedCategory, animation: animation)
                
                // 카테고리에 따라 다른 뷰를 표시
                TabView(selection: $selectedCategory) {
                    ForEach(HomeCategory.allCases, id: \.self) { homeCategory in
                        contentView(for: homeCategory)
                            .tag(homeCategory)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // 광고
                //                GADBanner()
                //                    .frame(height: GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width).size.height)
            }
            .navigationBarTitleDisplayMode(.inline) // 타이틀을 중앙에 배치
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(colorScheme == .dark ? "AppFont" : "Apptitle") // 색상 모드에 따라 이미지 변경
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: NoticeListView()) {
                        Image(systemName: "bell")
                            .font(.system(size: 16))
                            .foregroundStyle(Color(.label))
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
    
    @ViewBuilder
    private func contentView(for homeCategory: HomeCategory) -> some View {
        switch homeCategory {
        case .all:
            BaseballListView(viewModel: stadiumViewModel, scheduleViewModel: scheduleViewModel)
        case .favoriteStadium:
            FavoritesView(viewModel: stadiumViewModel)
        }
    }
}

