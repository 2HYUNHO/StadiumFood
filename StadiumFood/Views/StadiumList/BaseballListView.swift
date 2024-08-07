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
    @ObservedObject var viewModel : StadiumViewModel
    @ObservedObject var scheduleViewModel: ScheduleViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @State private var navigateToDetail: Bool = false
    @State private var selectedStadium: StadiumModel? = nil
    
    var body: some View {
        NavigationStack {
            List {
                // 일정이 있는 구장 필터링 및 표시
                let filteredStadiums = scheduleViewModel.filteredStadiums(from: viewModel.stadiums)
                ForEach(filteredStadiums.withSchedule) { stadium in
                    stadiumRow(stadium: stadium)
                }
                
                // 일정이 없는 구장 필터링 및 표시
                ForEach(filteredStadiums.withoutSchedule) { stadium in
                    stadiumRow(stadium: stadium)
                }
            }
            .listStyle(.plain)
            .onAppear {
//                GADFull.shared.loadInterstitialAd()
                // 오늘 날짜의 일정을 미리 로드
                Task {
                    await scheduleViewModel.fetchSchedules(for: Date())
                }
            }
            .navigationDestination(isPresented: $navigateToDetail) {
                if let stadium = selectedStadium {
                    viewModel.destinationViewForStadium(stadium, favoritesViewModel: favoritesViewModel)
                } else {
                    EmptyView()
                }
            }
            .refreshable {
                await viewModel.reload()
            }
        }
    }
    
    private func stadiumRow(stadium: StadiumModel) -> some View {
        HStack {
            Button {
                selectedStadium = stadium
                navigateToDetail = true // 광고 설정 후 제거
//                GADFull.shared.displayInterstitialAd {
//                    navigateToDetail = true
//                }
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
                            HStack {
                                Text(stadium.name)
                                    .padding(.leading, 5)
                                    .padding(.bottom, 3)
                                    .font(.system(size: 18))
                                    .bold()
                                
                                // 매치 레이블
                                if scheduleViewModel.schedules.first(where: {
                                    $0.stadiumName == stadium.name &&
                                    Calendar.current.isDate($0.date, inSameDayAs: Date())
                                }) != nil {
                                    Text("진행")
                                        .font(.system(size: 12))
                                        .bold()
                                        .padding(.vertical, 2)
                                        .padding(.horizontal, 5)
                                        .background(Color.green)
                                        .foregroundStyle(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                        .padding(.leading, 5)
                                }
                            }
                            
                            if let schedule = scheduleViewModel.schedules.first(where: {
                                $0.stadiumName == stadium.name &&
                                Calendar.current.isDate($0.date, inSameDayAs: Date())
                            }) {
                                VStack(alignment: .leading) {
                                    Text(scheduleViewModel.formattedDate(for: schedule.date))
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                        .padding(.leading, 5)
                                        .padding(.bottom, 3)
                                    
                                    Text("\(schedule.home) vs \(schedule.away)")
                                        .font(.system(size: 14))
                                        .padding(.leading, 5)
                                }
                            } else {
                                Text("경기일정이 없습니다")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                    .padding(.leading, 5)
                                    .padding(.bottom, 3)
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            Image(systemName: favoritesViewModel.favoriteStadiums.contains(stadium.name) ? "star.fill" : "star")
                .foregroundStyle(favoritesViewModel.favoriteStadiums.contains(stadium.name) ? Color(.label) : .gray)
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
