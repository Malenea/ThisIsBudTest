//
//  TableViewCell.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

open class TableViewCell: UITableViewCell, Stylable {

    // MARK: - Properties
    public var customStyle: Styler? {
        didSet { styleChildren() }
    }

    public let onStyleChange = TriggeredEvent<Styler>()

    public private(set) lazy var cachedStyle: Styler = currentStyle()

    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        setup()
    }

    override open func didMoveToSuperview() {
        super.didMoveToSuperview()

        styleChildren()
    }

    override open func removeFromSuperview() {
        super.removeFromSuperview()

        styleChildren()
    }

    override open func didMoveToWindow() {
        super.didMoveToWindow()

        styleChildren()
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        styleDidChange()
    }

    // MARK: - Methods
    open func setup() {
        preservesSuperviewLayoutMargins = true

        styleDidChange()
    }

    open func styleDidChange() {
        cachedStyle = currentStyle()
        onStyleChange.trigger(cachedStyle)
    }
}
