//
//  TableView.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

open class TableView: UITableView, Stylable {

    // MARK: - Properties
    public var customStyle: Styler? {
        didSet { styleChildren() }
    }

    public let onStyleChange = TriggeredEvent<Styler>()

    public private(set) lazy var cachedStyle: Styler = currentStyle()

    // MARK: - Life Cycle
    public required init() {
        super.init(frame: .zero, style: .grouped)

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
        separatorStyle = .none

        styleDidChange()
    }

    open func styleDidChange() {
        cachedStyle = currentStyle()
        onStyleChange.trigger(cachedStyle)

        backgroundColor = cachedStyle.color.common.background
    }

    open func reload() {
        DispatchQueue.main.async { [weak self] in
            self?.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }

}
