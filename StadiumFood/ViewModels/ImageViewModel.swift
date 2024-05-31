//
//  ImageViewModel.swift
//  StadiumFood
//
//  Created by 이현호 on 5/29/24.
//

import SwiftUI
import Combine
import FirebaseStorage

class ImageViewModel: ObservableObject {
    @Published var image: UIImage? // 이미지 저장할 변수
    
    private var storage = Storage.storage()
    private var imageURL: String
    
    init(imageURL: String) {
        self.imageURL = imageURL
        fetchImage() // 이미지 로드
    }
    
    // 이미지를 가져오는 함수
    func fetchImage() {
        let storageRef = storage.reference(forURL: imageURL)
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = uiImage
                }
            } else {
                print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}
