//
//  BaseballListView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/22/24.
//

import SwiftUI
import Kingfisher

struct BaseballListView: View {
    @ObservedObject var viewModel: StadiumViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        List(viewModel.stadiums) { stadium in
            NavigationLink(destination: viewModel.destinationViewForStadium(stadium, favoritesViewModel: favoritesViewModel)) {
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
        }
        .listStyle(.plain)
    }
}

