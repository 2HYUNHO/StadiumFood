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
        let bannerSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width)
        let bannerView = GADBannerView(adSize: bannerSize)
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" // test Key
        bannerView.rootViewController = viewController
        viewController.view.addSubview(bannerView)
        
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            bannerView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            bannerView.widthAnchor.constraint(equalTo: viewController.view.widthAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: bannerSize.size.height)
        ])
        
        bannerView.load(GADRequest())
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

