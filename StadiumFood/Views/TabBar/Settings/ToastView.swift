//
//  ToastView.swift
//  StadiumFood
//
//  Created by 이현호 on 7/26/24.
//

import SwiftUI

struct ToastView: View {
    let message: String
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack {
            if isShowing {
                Text(message)
                    .padding()
                    .frame(height: 40)
                    .background(Color.gray.opacity(0.5))
                    .foregroundStyle(.white)
                    .cornerRadius(8)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.5), value: isShowing)
            }
        }
    }
}
