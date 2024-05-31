//
//  TabBarView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/23/24.
//

import SwiftUI

struct TabBarView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                }
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "star.fill")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
        }
        .tint(.black)
    }
}
