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
    
    @State private var isEditing: Bool = false
    @Namespace private var animation
    
    var body: some View {
        NavigationView {
            VStack {
                if !favoritesViewModel.favoriteStadiums.isEmpty {
                    FavoriteListView(viewModel: viewModel, stadiumNames: favoritesViewModel.favoriteStadiums, isEditing: $isEditing)
                } else {
                    Text("즐겨찾기된 구장이 없습니다.")
                        .foregroundColor(.gray)
                        .padding(8)
                }
            }
            .navigationBarTitle("즐겨찾기", displayMode: .inline)
            .onAppear {
                favoritesViewModel.loadFavorites()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                        .foregroundStyle(.blue)
                }
            }
        }
    }
}
