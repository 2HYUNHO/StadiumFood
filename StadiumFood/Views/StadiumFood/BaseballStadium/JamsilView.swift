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
    
    var body: some View {
        StadiumView(selectedFloor: selectedFloor,
                    animation: animation,
                    stadiumId: "Jamsil",
                    stadiumName: "서울 잠실야구장",
                    floorIds: ["1층": "1F", "2층": "2F", "3/4층": "3F"],
                    sportsCategory: .baseball)
    }
}
