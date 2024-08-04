//
//  FavoritesView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/23/24.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: StadiumViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @State private var navigateToDetail: Bool = false
    @State private var selectedStadium: StadiumModel? = nil
    @Namespace private var animation
    
    var body: some View {
      
            VStack {
                HStack {
                    if !favoritesViewModel.favoriteStadiums.isEmpty {
                        FavoriteListView(viewModel: viewModel, stadiumNames: favoritesViewModel.favoriteStadiums)
                    } else {
                        Text("즐겨찾기된 구장이 없습니다.")
                            .foregroundColor(.gray)
                            .padding(8)
                    }
                }
            }
            .onAppear {
                favoritesViewModel.loadFavorites()
            }
        
    }
}
