//
//  FavoritesViewModel.swift
//  StadiumFood
//
//  Created by 이현호 on 6/5/24.
//

import Foundation
import SwiftUI

class FavoritesViewModel: ObservableObject {
    private let favoritesKey = "favoriteStadiums"
    
    @Published var favoriteStadiums: [String]
    
    init() {
        self.favoriteStadiums = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        loadFavorites() // 초기화 시 즐겨찾기 로드
    }
    
    // 즐겨찾기 구장 추가
    func addFavoriteStadium(_ stadiumName: String) {
        if !favoriteStadiums.contains(stadiumName) {
            favoriteStadiums.append(stadiumName)
            saveFavorites()
        }
    }
    
    // 즐겨찾기 구장 제거
    func removeFavoriteStadium(_ stadiumName: String) {
        if let index = favoriteStadiums.firstIndex(of: stadiumName) {
            favoriteStadiums.remove(at: index)
            saveFavorites()
        }
    }
    
    // 즐겨찾기 구장 제거(편집 사용 시)
    func removeFavoriteStadium(at offset: IndexSet) {
        favoriteStadiums.remove(atOffsets: offset)
        saveFavorites()
    }
    
    
    // 즐겨찾기 구장 이동(편집 사용 시)
    func moveFavoriteStadium(from source: IndexSet, to destination: Int) {
        favoriteStadiums.move(fromOffsets: source, toOffset: destination)
        saveFavorites()
    }
    
    // UserDefaults에 저장
    private func saveFavorites() {
        UserDefaults.standard.set(favoriteStadiums, forKey: favoritesKey)
    }
    
    // 로드
    func loadFavorites() {
        favoriteStadiums = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
    }
}
