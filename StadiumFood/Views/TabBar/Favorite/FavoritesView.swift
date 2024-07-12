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
    
    @State private var selectedCategory: SportsCategory = .baseball
    @State private var isEditing: Bool = false
    @Namespace private var animation
    
    var body: some View {
        NavigationView {
            VStack {
                CategoryPickerView(selectedCategory: $selectedCategory, animation: animation)
                
                TabView(selection: $selectedCategory) {
                    ForEach(SportsCategory.allCases, id: \.self) { category in
                        if let stadiums = favoritesViewModel.favoriteStadiums[category.rawValue], !stadiums.isEmpty {
                            FavoriteListView(viewModel: viewModel, category: category, stadiumNames: stadiums, isEditing: $isEditing)
                                .tag(category)
                        } else {
                            Text("즐겨찾기된 구장이 없습니다.")
                                .foregroundColor(.gray)
                                .padding(8)
                                .tag(category)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
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
