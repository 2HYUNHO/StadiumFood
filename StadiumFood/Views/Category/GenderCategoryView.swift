//
//  GenderCategoryView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/23/24.
//

import SwiftUI

struct GenderCategoryView: View {
    let sportsCategory: SportsCategory
    @State private var selectedGender: Gender = .male
    
    var body: some View {
        VStack {
            Picker("Gender", selection: $selectedGender) {
                ForEach(Gender.allCases, id: \.self) { gender in
                    Text(gender.rawValue)
                        .tag(gender)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            TabView(selection: $selectedGender) {
                ForEach(Gender.allCases, id: \.self) { gender in
                    GenderContentView(sportsCategory: sportsCategory, gender: gender)
                        .tag(gender)
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}
