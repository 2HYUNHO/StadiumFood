//
//  LandersFieldView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/24/24.
//

import SwiftUI

struct LandersFieldView: View {
    @Namespace private var animation
    @State private var selectedFloor: FloorCategoryModel.FloorCategory = .firstFloor
    
    var body: some View {
        StadiumView(selectedFloor: selectedFloor,
                    animation: animation,
                    stadiumId: "LandersField",
                    stadiumName: "인천 SSG랜더스필드",
                    floorIds: ["1층": "1F", "2층": "2F", "3층": "3F"],
                    sportsCategory: .baseball)
    }
}
