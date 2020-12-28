//
//  DimensionStyler.swift
//  ThisIsBud
//
//  Created by Motionmetrics on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

// A configurator that defines constants view sizes.
public protocol DimensionStyler {

    var common: CommonDimensionStyle { get }

}

// Default dimension values.
public extension DimensionStyler {

    var common: CommonDimensionStyle { .init() }

}

// Concrete object for dimesnion constants.
public struct DimensionStyle: DimensionStyler {

    public init() {}

}
