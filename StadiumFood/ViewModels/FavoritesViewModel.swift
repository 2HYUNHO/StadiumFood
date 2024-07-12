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
    
    @Published var favoriteStadiums: [String: [String]]
    
    init() {
        self.favoriteStadiums = UserDefaults.standard.dictionary(forKey: favoritesKey) as? [String: [String]] ?? [:]
        loadFavorites() // 초기화 시 즐겨찾기 로드
    }
    
    // 즐겨찾기 구장 추가
    func addFavoriteStadium(_ stadiumName: String, category: String) {
        if var categoryFavorites = favoriteStadiums[category] {
            if !categoryFavorites.contains(stadiumName) {
                categoryFavorites.append(stadiumName)
                favoriteStadiums[category] = categoryFavorites
                saveFavorites()
            }
        } else {
            favoriteStadiums[category] = [stadiumName]
            saveFavorites()
        }
    }
    
    // 즐겨찾기 구장 제거
    func removeFavoriteStadium(_ stadiumName: String, category: String) {
        if var categoryFavorites = favoriteStadiums[category], let index = categoryFavorites.firstIndex(of: stadiumName) {
            categoryFavorites.remove(at: index)
            favoriteStadiums[category] = categoryFavorites
            saveFavorites()
        }
    }
    
    // 즐겨찾기 구장 제거(편집 사용 시)
    func removeFavoriteStadium(at offset: IndexSet, category: String) {
        if var categoryFavorites = favoriteStadiums[category] {
            categoryFavorites.remove(atOffsets: offset)
            favoriteStadiums[category] = categoryFavorites
            saveFavorites()
        }
    }
    
    // 즐겨찾기 구장 이동(편집 사용 시)
    func moveFavoriteStadium(from source: IndexSet, to destination: Int, category: String) {
        if var categoryFavorites = favoriteStadiums[category] {
            categoryFavorites.move(fromOffsets: source, toOffset: destination)
            favoriteStadiums[category] = categoryFavorites
            saveFavorites()
        }
    }
    
    // UserDefaults에 저장
    private func saveFavorites() {
        let nsDictionary = favoriteStadiums.mapValues { NSArray(array: $0) } as NSDictionary
        UserDefaults.standard.set(nsDictionary, forKey: favoritesKey)
    }
    
    // 로드
    func loadFavorites() {
        if let dictionary = UserDefaults.standard.dictionary(forKey: favoritesKey) as? [String: NSArray] {
            self.favoriteStadiums = dictionary.mapValues { $0 as? [String] ?? [] }
        } else {
            self.favoriteStadiums = [:]
        }
    }
}
