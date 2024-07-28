////
////  GADFull.swift
////  StadiumFood
////
////  Created by 이현호 on 7/29/24.
////
//
//import UIKit
//import GoogleMobileAds //구글애드몹 라이브러리 임포트
//
//// 구글에서 제공하는 테스트용 광고단위 ID
//let interstitialID = "ca-app-pub-3940256099942544/4411468910"
//
//// 전면광고 객체의 Delegate설정을 위해 GADInterstitialDelegate 상속
//class ViewController: UIViewController, GADInterstitialDelegate {
//       var interestitial : GADInterstitial! // 전면 광고 객체 생성
//   
//    override func viewDidLoad() {
//        DispatchQueue.main.async { // view생성시 함수를 통해 전면광고 호출
//            self.interestitial = self.createAndLoadInterstitial()
//        }
//      // qos로 전면광고 객체를 먼저 불러온 이후에 전면 광고 노출 조건 확인
//      if checkAdsPopup() == true {
//          self.interestitial.present(fromRootViewController: self)
//      }
//    }
//    
//    func checkAdsPopup() -> Bool {
//        // 광고 노출 여부 판단을 위한 코드
//    }
//    
//    // 전면광고를 로드하여 반환하는 함수
//    func createAndLoadInterstitial() -> GADInterstitial {
//      let interstitial =
//          GADInterstitial(adUnitID: interstitialID )
//      interstitial.delegate = self
//      interstitial.load(GADRequest())
//      return interstitial
//    }
//    
//    // 전면광고를 닫았을때(즉 광고가 끝나는 시점을 트래킹하는 함수) 끝나는 시점을 기준으로 신규 전면광고 생성
//    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
//        print("play interestitial is finished")
//        self.interestitial = createAndLoadInterstitial()
//    }
//}
