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
    
    let stadiumNames: [String]
    @Binding var isEditing: Bool
    
    var body: some View {
        List {
            ForEach(stadiumNames, id: \.self) { stadiumName in
                if let stadium = viewModel.stadiums.first(where: { $0.name == stadiumName }) {
                    NavigationLink(destination: viewModel.destinationViewForStadium(stadium, favoritesViewModel: favoritesViewModel)) {
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
    }
}
