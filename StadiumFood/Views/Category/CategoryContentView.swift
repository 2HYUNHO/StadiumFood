//
//  CategoryContentView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/22/24.
//

import SwiftUI

struct CategoryContentView: View {
    let stadiumViewModel: StadiumViewModel
    let sportsCategory: SportsCategory
    
    var body: some View {
        Group {
            switch sportsCategory {
            case .baseball:
                BaseballListView(viewModel: stadiumViewModel)
            case .basketball:
                GenderCategoryView(sportsCategory: sportsCategory)
            case .soccer:
                SoccerListView()
            case .volleyball:
                GenderCategoryView(sportsCategory: sportsCategory)
            }
        }
    }
}
