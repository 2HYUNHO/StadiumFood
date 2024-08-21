//
//  GADBanner.swift
//  StadiumFood
//
//  Created by 이현호 on 7/28/24.
//

import SwiftUI
import GoogleMobileAds

struct GADBanner: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let bannerSize = GADLandscapeAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width)
        let bannerView = GADBannerView(adSize: bannerSize)
        
        bannerView.rootViewController = viewController
        viewController.view.addSubview(bannerView)
        viewController.view.frame = CGRect(origin: .zero, size: bannerSize.size)
        
        bannerView.adUnitID = "ca-app-pub-5176755014867221/8334619423" // BannerID
        
        #if DEBUG
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" // TestID
        #endif
        
//        bannerView.delegate = context.coordinator // Error
        
        bannerView.load(GADRequest())
        return viewController
    }
    
    func updateUIViewController(_ viewController: UIViewController, context: Context) { }
    
//    func makeCoordinator() -> Coordinator {
//        Coordinator()
//    }
//    
//    class Coordinator: NSObject, GADBannerViewDelegate {
//            func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
//                // 에러 코드 및 메시지 출력
//                print("배너광고 오류코드: \(error._code), 배너광고 오류메시지: \(error.localizedDescription)")
//            }
//        }
}

