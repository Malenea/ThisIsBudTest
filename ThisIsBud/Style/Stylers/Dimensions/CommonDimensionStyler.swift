//
//  CommonDimensionStyler.swift
//  ThisIsBud
//
//  Created by Motionmetrics on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

// Defines default values for common dimensions constants.
public struct CommonDimensionStyle {

    public init() {}

    // MARK: - Components
    public var componentDefaultSize: CGFloat = 48.0
    public var tableCellHeight: CGFloat = 100.0
    public var separatorDefaultHeight: CGFloat = 1.0

    // MARK: - Spacings
    public struct HorizontalSpacing {

        public var xxLarge: CGFloat = 36.0
        public var xLarge: CGFloat = 30.0
        public var large: CGFloat = 24.0
        public var mediumLarge: CGFloat = 20.0
        public var medium: CGFloat = 16.0
        public var mediumSmall: CGFloat = 12.0
        public var small: CGFloat = 8.0
        public var xSmall: CGFloat = 4.0

    }

    public struct VerticalSpacing {

        public var xxLarge: CGFloat = 36.0
        public var xLarge: CGFloat = 30.0
        public var large: CGFloat = 20.0
        public var mediumLarge: CGFloat = 16.0
        public var medium: CGFloat = 12.0
        public var mediumSmall: CGFloat = 10.0
        public var small: CGFloat = 8.0
        public var xSmall: CGFloat = 4.0
        public var xxSmall: CGFloat = 2.0

    }

    public struct CornerRadius {

        public var big: CGFloat = 16.0
        public var medium: CGFloat = 8.0
        public var small: CGFloat = 4.0
    }

    public var horizontalSpacing: HorizontalSpacing = .init()
    public var verticalSpacing: VerticalSpacing = .init()
    public var cornerRadius: CornerRadius = .init()

}
