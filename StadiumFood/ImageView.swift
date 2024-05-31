//
//  ImageView.swift
//  StadiumFood
//
//  Created by 이현호 on 5/29/24.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var viewModel: ImageViewModel
    
    init(imageURL: String) {
        self.viewModel = ImageViewModel(imageURL: imageURL)
    }
    
    var body: some View {
        if let image = viewModel.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
