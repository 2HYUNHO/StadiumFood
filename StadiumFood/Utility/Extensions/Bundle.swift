//
//  Bundle.swift
//  StadiumFood
//
//  Created by 이현호 on 7/12/24.
//

import Foundation

extension Bundle {
    var appVersion: String? {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String else { return nil }
        return version
    }
}
