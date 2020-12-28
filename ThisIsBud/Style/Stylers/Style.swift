//
//  Style.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation

public protocol Styler {

    var color: ColorStyler { get }
    var dimension: DimensionStyler { get }
    var font: FontStyler { get }

}

public extension Styler {

    var color: ColorStyler { ColorStyle() }
    var dimension: DimensionStyler { DimensionStyle() }
    var font: FontStyler { FontStyle() }

}

// Concrete object that contains style constants
public struct Style: Styler {

    public static let `default` = Style()

    private init() {}

}
