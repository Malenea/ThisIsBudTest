//
//  CommonColorStyler.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

public struct CommonColorStyle {

    private init() {}

    public static let `default` = CommonColorStyle()

    // MARK: - Background
    public var background: UIColor = ThisIsBudColors.offWhite
    public var negativeBackground: UIColor = ThisIsBudColors.charcoal

    // MARK: - Separator
    public var defaultSeparator: UIColor = ThisIsBudColors.grayLightest

    // MARK: - Label
    public var labelText: UIColor = ThisIsBudColors.charcoal
    public var labelSubText: UIColor = ThisIsBudColors.grayLighter

    // MARK: - Components' items
    public var itemOnBlackBG: UIColor = ThisIsBudColors.offWhite
    public var itemOnWhiteBG: UIColor = ThisIsBudColors.charcoal

    // MARK: - Selection
    public var destructiveSelection: UIColor = ThisIsBudColors.redLight

    // MARK: - Button
    public var destructiveButtonBG: UIColor = ThisIsBudColors.red
    public var destructiveButtonText: UIColor = ThisIsBudColors.offWhite
    public var destructiveButtonTextHighlighted: UIColor = ThisIsBudColors.grayLightest

}
