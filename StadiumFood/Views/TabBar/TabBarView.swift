//
//  TabBarView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/23/24.
//

import SwiftUI

struct TabBarView: View {
    @StateObject var viewModel = StadiumViewModel()
    @StateObject var favoritesViewModel = FavoritesViewModel()
    @State private var selectedTab = 0 // 현재 선택된 탭의 인덱스
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 홈화면
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                }
                .tag(0)
            
            // 즐겨찾기화면
            FavoritesView(viewModel: viewModel)
                .environmentObject(favoritesViewModel)
                .tabItem {
                    Image(systemName: "star.fill")
                }
                .tag(1)
            
            // 설정화면
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
                .tag(2)
        }
        .tint(Color(.label))
        .environmentObject(favoritesViewModel)
    }
}
