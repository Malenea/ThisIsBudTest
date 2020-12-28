//
//  UIStackView+Extensions.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Add subviews
extension UIStackView {

    func addArrangedSubviews(_ subviews: UIView...) {
        addArrangedSubviews(subviews)
    }

    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach {
            addArrangedSubview($0)
        }
    }

}
