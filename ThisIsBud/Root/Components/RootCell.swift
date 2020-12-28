//
//  RootCell.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

final class RootCell: TableViewCell {

    // MARK: - Identifier
    static let reuseIdentifier = "RootCell"

    // MARK: - Components
    private lazy var logoView = makeLogoView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var categoryLabel = makeCategoryLabel()
    private lazy var valueLabel = makeValueLabel()
    private lazy var separatorView = makeSeparatorView()

    // MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        styleDidChange()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupUI()
        styleDidChange()
    }

    override func styleDidChange() {
        backgroundColor = cachedStyle.color.common.background
        contentView.backgroundColor = cachedStyle.color.common.background
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        logoView.image = UIImage(named: "ic_refresh")
        titleLabel.text = ""
        categoryLabel.text = ""
        valueLabel.text = ""
        setSelected(false, animated: false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        contentView.backgroundColor = selected ? cachedStyle.color.common.destructiveSelection : cachedStyle.color.common.background
    }

}

extension RootCell {

    func updateCell(isSelected: Bool, transaction: Transaction) {
        _ = CachedRequest.request(endpoint: .other(transaction.product.icon)) { [weak self] data, response, error, cached in
            if let data = data {
                DispatchQueue.main.async {
                    self?.logoView.image = UIImage(data: data)
                }
            }
        }
        titleLabel.text = transaction.description
        categoryLabel.text = transaction.category
        let symbol = transaction.amount.currency_iso.getSymbolForCurrencyCode()
        let value = String(format: "%.02f", transaction.amount.value)
        valueLabel.text = "\(symbol)\(value)"

        setSelected(isSelected, animated: false)
    }

}

private extension RootCell {

    func setupUI() {
        contentView.prepareSubviewsForAutolayout(logoView, titleLabel, categoryLabel, valueLabel, separatorView)
        NSLayoutConstraint.activate([
            /// Logo layout
            logoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: cachedStyle.dimension.common.horizontalSpacing.medium),
            logoView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            logoView.heightAnchor.constraint(equalToConstant: cachedStyle.dimension.common.componentDefaultSize),
            logoView.widthAnchor.constraint(equalToConstant: cachedStyle.dimension.common.componentDefaultSize),

            /// Title layout
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: cachedStyle.dimension.common.verticalSpacing.medium),
            titleLabel.leadingAnchor.constraint(equalTo: logoView.trailingAnchor, constant: cachedStyle.dimension.common.horizontalSpacing.medium),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: valueLabel.leadingAnchor, constant: -cachedStyle.dimension.common.horizontalSpacing.medium),

            /// Category layout
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: cachedStyle.dimension.common.verticalSpacing.small),
            categoryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(lessThanOrEqualTo: valueLabel.leadingAnchor, constant: -cachedStyle.dimension.common.horizontalSpacing.medium),

            /// Value layout
            valueLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -cachedStyle.dimension.common.horizontalSpacing.medium),

            // Separator layout
            separatorView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: cachedStyle.dimension.common.verticalSpacing.medium),
            separatorView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: cachedStyle.dimension.common.separatorDefaultHeight),

            /// Content view auto-layout set
            contentView.bottomAnchor.constraint(equalTo: separatorView.bottomAnchor)
        ])

        selectionStyle = .none
    }

}

private extension RootCell {

    func makeLogoView() -> UIImageView {
        let logoView = UIImageView()
        return logoView
    }

    func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        titleLabel.numberOfLines = 0
        titleLabel.font = cachedStyle.font.common.subTitleBoldFont
        titleLabel.textColor = cachedStyle.color.common.labelText
        return titleLabel
    }

    func makeCategoryLabel() -> UILabel {
        let categoryLabel = UILabel()
        categoryLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        categoryLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        categoryLabel.numberOfLines = 0
        categoryLabel.font = cachedStyle.font.common.defaultFont
        categoryLabel.textColor = cachedStyle.color.common.labelSubText
        return categoryLabel
    }

    func makeValueLabel() -> UILabel {
        let valueLabel = UILabel()
        valueLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        valueLabel.font = cachedStyle.font.common.subTitleBoldFont
        valueLabel.textColor = cachedStyle.color.common.labelText
        return valueLabel
    }

    func makeSeparatorView() -> View {
        let separatorView = View()
        separatorView.backgroundColor = cachedStyle.color.common.defaultSeparator
        return separatorView
    }

}
