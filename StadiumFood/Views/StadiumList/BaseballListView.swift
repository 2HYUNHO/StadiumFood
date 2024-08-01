//
//  BaseballListView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/22/24.
//

// BaseballListView.swift

import SwiftUI
import Kingfisher

struct BaseballListView: View {
    @ObservedObject var viewModel: StadiumViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @StateObject private var interstitialAdManager = GADFull()
    @State private var navigateToDetail: Bool = false
    @State private var selectedStadium: StadiumModel? = nil
    
    var body: some View {
        NavigationStack {
            List(viewModel.stadiums) { stadium in
                HStack {
                    Button {
                        // 선택한 구장 설정
                        selectedStadium = stadium
                        if interstitialAdManager.interstitialAdLoaded {
                            interstitialAdManager.displayInterstitialAd {
                                // 광고가 닫힌 후 네비게이션 수행
                                navigateToDetail = true
                            }
                        } else {
                            // 광고가 로드되지 않은 경우 바로 네비게이션 수행
                            navigateToDetail = true
                        }
                    } label: {
                        VStack(alignment: .leading) {
                            HStack {
                                KFImage(URL(string: stadium.imageURL))
                                    .resizable()
                                    .placeholder {
                                        ProgressView()
                                    }
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(10)
                                
                                VStack(alignment: .leading) {
                                    Text(stadium.name)
                                        .padding(.leading, 5)
                                        .padding(.bottom, 3)
                                        .font(.system(size: 18))
                                        .bold()
                                    Text(stadium.teams.joined(separator: ", "))
                                        .padding(.leading, 5)
                                        .font(.system(size: 16))
                                }
                            }
                        }
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
            .listStyle(.plain)
            .onAppear {
                interstitialAdManager.loadInterstitialAd()
            }
            .navigationDestination(isPresented: $navigateToDetail) {
                // 현재 선택된 구장이 nil이 아닐 경우에만 네비게이션을 수행
                if let stadium = selectedStadium {
                    viewModel.destinationViewForStadium(stadium, favoritesViewModel: favoritesViewModel)
                } else {
                    EmptyView()
                }
            }
        }
    }
}

