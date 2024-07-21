//
//  EaglesParkView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/24/24.
//

import SwiftUI

struct EaglesParkView: View {
    @Namespace private var animation
    @State private var selectedFloor: FloorCategoryModel.FloorCategory = .firstBase
    private let stadium = StadiumEnum.eaglesPark
    
    var body: some View {
        StadiumView(selectedFloor: selectedFloor,
                    animation: animation,
                    stadiumId: stadium.id,
                    stadiumName: stadium.name,
                    floorIds: stadium.floors,
                    sportsCategory: .baseball)
    }
}
