//
//  CommonFontStyle.swift
//  ThisIsBud
//
//  Created by Motionmetrics on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

// Defines default values for common fonts.
public struct CommonFontStyle {

    // MARK: - Fonts
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 24.0, weight: .semibold)
    public var subTitleFont: UIFont = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
    public var subTitleBoldFont: UIFont = UIFont.systemFont(ofSize: 16.0, weight: .bold)
    public var defaultFont: UIFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)

    public init() {
    }

}
