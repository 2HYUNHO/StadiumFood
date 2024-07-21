//
//  WizParkView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/24/24.
//

import SwiftUI

struct WizParkView: View {
    @Namespace private var animation
    @State private var selectedFloor: FloorCategoryModel.FloorCategory = .wizParkTopOfSecondFloor
    private let stadium = StadiumEnum.wizPark
    
    var body: some View {
        StadiumView(selectedFloor: selectedFloor,
                    animation: animation,
                    stadiumId: stadium.id,
                    stadiumName: stadium.name,
                    floorIds: stadium.floors,
                    sportsCategory: .baseball)
    }
}
