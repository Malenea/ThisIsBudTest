//
//  ThisIsBudColors.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

public enum ThisIsBudColors {

    public static let offWhite = UIColor(rgbValue: 0xfbfbfb)
    public static let charcoal = UIColor(rgbValue: 0x424347)

    public static let grayLight = UIColor(rgbValue: 0x6a6d72)
    public static let grayLighter = UIColor(rgbValue: 0x8c8b91)
    public static let grayLightest = UIColor(rgbValue: 0xebebeb)

    public static let redDark = UIColor(rgbValue: 0x7e4949)
    public static let red = UIColor(rgbValue: 0xeb0037)
    public static let redLight = UIColor(rgbValue: 0xfbccd7)
    public static let redLightest = UIColor(rgbValue: 0xfde5eb)

}

public extension UIColor {

    enum ColorAlpha: CGFloat {
        case common25 = 0.25
        case common50 = 0.5
        case common75 = 0.75

        case selectedTab = 1.0
        case unselectedTab = 0.4
    }

    func withAlpha(_ alpha: ColorAlpha) -> UIColor {
        withAlphaComponent(alpha.rawValue)
    }

}
