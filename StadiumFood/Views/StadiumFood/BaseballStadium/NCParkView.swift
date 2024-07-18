//
//  NCParkView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/24/24.
//

import SwiftUI

struct NCParkView: View {
    @Namespace private var animation
    @State private var selectedFloor: FloorCategoryModel.FloorCategory = .firstFloor
    
    var body: some View {
        StadiumView(selectedFloor: selectedFloor,
                    animation: animation,
                    stadiumId: "NCPark",
                    stadiumName: "창원 NC파크",
                    floorIds: ["1층": "1F", "2층": "2F", "3층": "3F",],
                    sportsCategory: .baseball)
    }
}

