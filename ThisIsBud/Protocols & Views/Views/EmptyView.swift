//
//  EmptyView.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

final class EmptyView: View {

    // MARK: - Observers
    public var tappedAddButton: VoidEvent = .init()

    // MARK: - Components
    private lazy var titleLabel = makeTitleLabel()
    private lazy var addButton = makeAddButton()

    // MARK: - Life Cycle
    required init() {
        super.init()

        setupUI()
        styleDidChange()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupUI()
        styleDidChange()
    }

    override func styleDidChange() {
        titleLabel.font = cachedStyle.font.common.subTitleFont
        titleLabel.textColor = cachedStyle.color.common.itemOnBlackBG

        addButton.backgroundColor = cachedStyle.color.common.negativeBackground
    }

}

private extension EmptyView {

    func setupUI() {
        blurView()

        prepareSubviewsForAutolayout(titleLabel, addButton)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            titleLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.8),

            addButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: cachedStyle.dimension.common.verticalSpacing.xLarge),
            addButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: cachedStyle.dimension.common.componentDefaultSize),
            addButton.widthAnchor.constraint(equalToConstant: cachedStyle.dimension.common.componentDefaultSize)
        ])

        addButton.roundView(with: cachedStyle.dimension.common.componentDefaultSize / 2.0)
    }

}

private extension EmptyView {

    func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.text = "We couldn't find any result, please refresh this page to retry."
        return titleLabel
    }

    func makeAddButton() -> Button {
        let addButton = Button()
        addButton.setImage(UIImage(named: "ic_refresh")?.tinted(with: cachedStyle.color.common.itemOnBlackBG), for: .normal)
        addButton.tapEvent.addObserver(self) { scene in
            scene.tappedAddButton.trigger()
        }
        return addButton
    }

}
