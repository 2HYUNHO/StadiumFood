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
    
    var body: some View {
        NavigationView {
            VStack {
                BaseballListView(viewModel: stadiumViewModel)
                
                // 광고
                GADBanner()
                    .frame(height: GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width).size.height)
            }
            .navigationTitle("구장먹거리")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
