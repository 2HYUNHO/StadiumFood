//
//  SwipeBackExtenstion.swift
//  StadiumFood
//
//  Created by 이현호 on 7/5/24.
//
import Foundation
import UIKit

// 스와이프 뒤로가기
extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func swipeBack(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
