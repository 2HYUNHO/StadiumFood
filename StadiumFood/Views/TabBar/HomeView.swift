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
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HomeCategoryView(selectedCategory: $selectedCategory, animation: animation)
                    .background(Color(hex: 0xC54D51))
                
                // 카테고리에 따라 다른 뷰를 표시
                TabView(selection: $selectedCategory) {
                    ForEach(HomeCategory.allCases, id: \.self) { homeCategory in
                        contentView(for: homeCategory)
                            .tag(homeCategory)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // 광고
                GADBanner()
                    .frame(width: UIScreen.main.bounds.width, height: GADLandscapeAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width).size.height)
            }
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("AppFont")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: NoticeListView()) {
                        Image(systemName: "bell.fill")
                            .font(.system(size: 16))
                            .foregroundStyle(Color(.white))
                    }
                }
            }
            .toolbarBackground(Color(hex: 0xC54D51), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.hidden)
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

