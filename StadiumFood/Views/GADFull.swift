//
//  GADFull.swift
//  StadiumFood
//
//  Created by 이현호 on 7/29/24.
//

import Foundation
import GoogleMobileAds

class GADFull: NSObject, GADFullScreenContentDelegate, ObservableObject {
    
    static let shared = GADFull() // 싱글턴 인스턴스
    private override init() {
        super.init()
        loadInterstitialAd() // 초기화 시 광고 로드
    }
    
    @Published var interstitialAdLoaded: Bool = false
    var interstitialAd: GADInterstitialAd?
    private var onAdDismissed: (() -> Void)?
    private var lastAdDisplayTime: Date? // 마지막 광고 표시 시간
    private let adDisplayInterval: TimeInterval = 60 // 1분
    
    // 전면 광고를 로드하는 함수
    func loadInterstitialAd() {
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-3940256099942544/4411468910", request: GADRequest()) { [weak self] ad, error in
            guard let self = self else { return }
            if let error = error {
                // 광고 로드 실패 시 에러 메시지를 출력합니다.
                print("전면 광고 로드 실패: \(error.localizedDescription)")
                self.interstitialAdLoaded = false
                return
            }
            print("전면 광고 로드 성공")
            self.interstitialAdLoaded = true
            self.interstitialAd = ad
            self.interstitialAd?.fullScreenContentDelegate = self
        }
    }
    
    // 전면 광고를 표시하는 함수
    func displayInterstitialAd(onDismiss: @escaping () -> Void) {
        let currentTime = Date()
        if let lastAdTime = lastAdDisplayTime, currentTime.timeIntervalSince(lastAdTime) < adDisplayInterval {
            print("광고가 너무 자주 표시되지 않도록 방지합니다.")
            onDismiss() // 광고가 표시되지 않으면 클로저를 즉시 호출
            return
        }
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let root = windowScene.windows.first?.rootViewController else {
            print("오류: 루트 뷰 컨트롤러를 찾을 수 없음")
            return
        }
        
        if let ad = interstitialAd {
            ad.present(fromRootViewController: root)
            self.interstitialAdLoaded = false
            self.onAdDismissed = onDismiss
            self.lastAdDisplayTime = currentTime
        } else {
            print("오류: 전면 광고가 준비되지 않음")
            self.loadInterstitialAd()
            onDismiss() // 광고가 준비되지 않으면 클로저를 즉시 호출
        }
    }
    
    // 전면 광고 표시 실패 알림
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("전면 광고 표시 실패: \(error.localizedDescription)")
        self.loadInterstitialAd()
    }
    
    // 전면 광고가 표시될 때 알림
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("전면 광고가 표시됩니다")
        self.interstitialAdLoaded = false
    }
    
    // 전면 광고가 닫혔을 때 알림
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("전면 광고가 닫혔습니다")
        self.loadInterstitialAd()
        self.onAdDismissed?() // 광고가 닫힌 후 클로저 호출
    }
}
