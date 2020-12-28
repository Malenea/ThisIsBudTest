//
//  Button.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

open class Button: UIButton, Stylable {

    // MARK: - Properties
    public var customStyle: Styler? {
        didSet { styleChildren() }
    }

    internal private(set) lazy var cachedStyle: Styler = currentStyle()

    // MARK: - Life Cycle
    public init() {
        super.init(frame: .zero)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        setup()
    }

    // Triggered when the button is clicked.
    public let tapEvent = VoidEvent()

    // MARK: - Methods
    open func setup() {
        addTarget(self, action: #selector(onTap), for: .touchUpInside)
        preservesSuperviewLayoutMargins = true

        styleDidChange()
    }

    open func styleDidChange() {
        cachedStyle = currentStyle()
    }

    override open func didMoveToSuperview() {
        super.didMoveToSuperview()

        styleDidChange()
    }

    override open func removeFromSuperview() {
        super.removeFromSuperview()

        styleChildren()
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        styleDidChange()
    }
}

// MARK: - Private helpers
private extension Button {

    @objc func onTap() {
        tapEvent.trigger()
    }

}
