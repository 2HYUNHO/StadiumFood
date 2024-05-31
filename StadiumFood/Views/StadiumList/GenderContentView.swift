//
//  GenderContentView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/23/24.
//

import SwiftUI

struct GenderContentView: View {
    let sportsCategory: SportsCategory
    let gender: Gender
    
    var body: some View {
        Text("\(sportsCategory.rawValue) \(gender.rawValue) Food View")
            .font(.largeTitle)
            .padding()
    }
}

