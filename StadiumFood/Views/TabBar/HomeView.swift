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
    @State private var showNoticeView: Bool = false
    
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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("구장먹거리")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(Color(.label))

                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showNoticeView = true
                    } label: {
                        Image(systemName: "bell")
                            .font(.system(size: 16))
                            .foregroundStyle(Color(.label))
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .navigationDestination(isPresented: $showNoticeView) {
            NoticeListView()
        }

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

