//
//  StadiumFoodApp.swift
//  StadiumFood
//
//  Created by 이현호 on 5/22/24.
//

import SwiftUI
import Firebase

@main
struct StadiumFoodApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
    }
}
