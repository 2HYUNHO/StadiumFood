//
//  WizParkView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/24/24.
//

import SwiftUI

struct WizParkView: View {
    @Namespace private var animation
    @State private var selectedFloor: FloorCategoryModel.FloorCategory = .firstFloor
    
    var body: some View {
        StadiumView(selectedFloor: selectedFloor,
                    animation: animation,
                    stadiumId: "KTwiz",
                    stadiumName: "수원 KT위즈파크",
                    floorIds: ["1층": "1F", "2층 상단": "2F TOP", "3층": "3F"],
                    sportsCategory: .baseball)
    }
}
