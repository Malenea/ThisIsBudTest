//
//  Stylable.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

// An object that can be styled.
public protocol Stylable: AnyObject {

    // Used to override the style.
    var customStyle: Styler? { get set }

    // Returns in order of existence: This object's custom style, the first parent with a custom style, or the default style.
    func currentStyle() -> Styler

    // Called when the style changes.
    func styleDidChange()

}

public extension Stylable where Self: UIView {

    // Returns in order of existence: This object's custom style, the first parent with a custom style, or the default style.
    func currentStyle() -> Styler {
        return customStyle ?? getParentCustomStyle() ?? Style.default
    }

    // Notify this view and subviews that the style has changed. Guarantees that the outermost view's `styleDidChange` method will be called after that of inner views.
    func styleChildren() {
        recursiveStyleChildren()
        styleDidChange()
    }
}

private extension UIView {

    // Find the first custom style in the superview hierarchy.
    func getParentCustomStyle() -> Styler? {
        guard let superview = superview else { return nil }

        // if the view has a custom style, return it
        if let typedSuperview = superview as? Stylable, let customStyle = typedSuperview.customStyle {
            return customStyle
        }

        // else check if the superview has a custom style
        return superview.getParentCustomStyle()
    }

    // Recursively notify subviews that the style has changed.
    func recursiveStyleChildren() {
        for view in subviews {
            // Propogate style through any `UIView`s
            guard let typedView = view as? Stylable & UIView else {
                view.recursiveStyleChildren()
                continue
            }

            // Propogate style to subviews that are not the child of a view that has set a custom style
            if typedView.customStyle == nil {
                typedView.recursiveStyleChildren()
                typedView.styleDidChange()
            }
        }
    }

}
