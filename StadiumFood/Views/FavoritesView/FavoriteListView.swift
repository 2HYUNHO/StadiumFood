//
//  FavoriteListView.swift
//  StadiumFood
//
//  Created by 이현호 on 6/6/24.
//

import SwiftUI
import Kingfisher

struct FavoriteListView: View {
    @ObservedObject var viewModel: StadiumViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @State private var navigateToDetail: Bool = false
    @State private var selectedStadium: StadiumModel? = nil
    
    let stadiumNames: [String]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(stadiumNames, id: \.self) { stadiumName in
                    if let stadium = viewModel.stadiums.first(where: { $0.name == stadiumName }) {
                        HStack {
                            Button {
                                // 선택한 구장
                                selectedStadium = stadium
                                navigateToDetail = true // 광고 설정 후 제거
//                                GADFull.shared.displayInterstitialAd {
//                                    // 광고가 닫힌 후 네비게이션 수행
//                                    navigateToDetail = true
//                                }
                            } label: {
                                HStack {
                                    KFImage(URL(string: stadium.imageURL))
                                        .resizable()
                                        .placeholder {
                                            ProgressView()
                                        }
                                        .frame(width:40, height: 40)
                                        .cornerRadius(5)
                                    
                                    Text(stadium.name)
                                        .foregroundStyle(.primary)
                                        .font(.system(size: 18))
                                        .lineLimit(1)
                                        .padding(.trailing, 5)
                                }
                                .padding(.vertical, 5)
                            }
                            
                            Spacer()
                            
                            Image(systemName: favoritesViewModel.favoriteStadiums.contains(stadium.name) ? "star.fill" : "star")
                                .foregroundStyle(favoritesViewModel.favoriteStadiums.contains(stadium.name) ? .black : .gray)
                                .font(.system(size: 20))
                                .onTapGesture {
                                    if favoritesViewModel.favoriteStadiums.contains(stadium.name) {
                                        favoritesViewModel.removeFavoriteStadium(stadium.name)
                                    } else {
                                        favoritesViewModel.addFavoriteStadium(stadium.name)
                                    }
                                }
                        }
                    }
                }
                .onDelete { offsets in
                    favoritesViewModel.removeFavoriteStadium(at: offsets)
                }
                .onMove { source, destination in
                    favoritesViewModel.moveFavoriteStadium(from: source, to: destination)
                }
                
                // 즐겨찾기 한 구장이 없을 때
                if stadiumNames.isEmpty {
                    Text("즐겨찾기된 구장이 없습니다.")
                        .foregroundStyle(.gray)
                        .padding(2)
                }
            }
            .listStyle(.plain)
            .onAppear {
                GADFull.shared.loadInterstitialAd()
            }
            .navigationDestination(isPresented: $navigateToDetail) {
                // 현재 선택된 구장이 nil이 아닐 경우에만 네비게이션 수행
                if let stadium = selectedStadium {
                    viewModel.destinationViewForStadium(stadium, favoritesViewModel: favoritesViewModel)
                } else {
                    EmptyView()
                }
            }
        }
    }
}
