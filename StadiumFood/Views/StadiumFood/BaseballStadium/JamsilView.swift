//
//  JamsilView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/24/24.
//

import SwiftUI

struct JamsilView: View {
    @Namespace private var animation
    @State private var selectedFloor: FloorCategoryModel.FloorCategory = .firstFloor
    private let stadium = StadiumEnum.jamsil
    
    var body: some View {
        StadiumView(selectedFloor: selectedFloor,
                    animation: animation,
                    stadiumId: stadium.id,
                    stadiumName: stadium.name,
                    floorIds: stadium.floors,
                    sportsCategory: .baseball)
    }
}
