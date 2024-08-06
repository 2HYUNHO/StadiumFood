//
//  LaunchView.swift
//  StadiumFood
//
//  Created by 이현호 on 8/4/24.
//

import SwiftUI

struct LaunchView: View {
    @State var isLaunching: Bool = true
    
    var body: some View {
        if isLaunching {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isLaunching = false
                    }
                }
        } else {
            TabBarView()
        }
    }
}

struct SplashView: View {
    
    var body: some View {
        ZStack {
            Color("BG")
                .ignoresSafeArea()
            Image("AppFont")
        }
    }
}

#Preview {
    LaunchView()
}
