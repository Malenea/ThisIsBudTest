//
//  FontStyler.swift
//  ThisIsBud
//
//  Created by Motionmetrics on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

// A configurator that defines constants view sizes.
public protocol FontStyler {

    var common: CommonFontStyle { get }

}

// Default dimension values.
public extension FontStyler {

    var common: CommonFontStyle { .init() }

}

// Concrete object for dimesnion constants.
public struct FontStyle: FontStyler {

    public init() {}

}
