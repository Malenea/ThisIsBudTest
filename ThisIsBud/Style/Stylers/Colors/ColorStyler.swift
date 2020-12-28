//
//  ColorStyler.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation

public protocol ColorStyler {

    var common: CommonColorStyle { get }

}

// Defines default values for color constants.
public extension ColorStyler {

    var common: CommonColorStyle { .default }

}

// Concrete object for color constants.
public struct ColorStyle: ColorStyler {

    public init() {}

}
