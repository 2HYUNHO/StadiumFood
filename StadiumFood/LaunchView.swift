//
//  LaunchView.swift
//  StadiumFood
//
//  Created by 이현호 on 8/4/24.
//

import SwiftUI

struct LaunchView: View {
    @State var isShowingLaunch: Bool = true
    @State var isShowingSplash: Bool = true
    
    var body: some View {
        if isShowingLaunch {
            ZStack {
                Color("BG")
                    .ignoresSafeArea()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            isShowingLaunch = false
                        }
                    }
            }
        } else {
            if isShowingSplash {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            isShowingSplash = false
                        }
                    }
            } else {
                TabBarView()
            }
        }
    }
}

struct SplashView: View {
    var body: some View {
        ZStack {
            Color("BG")
                .ignoresSafeArea()
            
            Image("AppFont")
                .resizable()
                .scaledToFit()
                .frame(width: 250)
        }
    }
}
