//
//  RootViewController.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import UIKit
import Foundation

class RootViewController: ViewController {

    // MARK: - Coordinator and model
    public weak var rootCoordinator: RootCoordinator?

    // MARK: - Components
    private lazy var tableView = makeTableView()
    private lazy var emptyView = makeEmptyView()
    private lazy var editButton = makeEditButton()
    private lazy var removeButton = makeRemoveButton()
    private var removeButtonHeightConstraint: NSLayoutConstraint?

    // MARK: - Items
    private var transactions: [Transaction] = []

    // MARK: - Control
    private var selectedIndexPath: [IndexPath] = []
    private var isEdit: Bool = false {
        didSet {
            editButton.title = isEdit ? "Done" : "Edit"
            tableView.allowsSelection = isEdit
            tableView.allowsSelectionDuringEditing = isEdit
            tableView.allowsMultipleSelection = isEdit
            tableView.allowsMultipleSelectionDuringEditing = isEdit

            if !isEdit {
                selectedIndexPath.forEach { tableView.cellForRow(at: $0)?.setSelected(false, animated: true) }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.removeButtonHeightConstraint?.constant = 0.0
                    UIView.animate(withDuration: 0.3) {
                        self.view.layoutIfNeeded()
                    }
                }
            }
        }
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        styleDidChange()

        rootCoordinator?.onTransactionsUpdated.addObserver(self) {
            $0.transactions = $1
            $0.tableView.reload()
        }
    }

    override func styleDidChange() {
        view.backgroundColor = cachedStyle.color.common.background
    }

}

// MARK: - UI setup
extension RootViewController {

    func setupUI() {
        /// Setup navigation bar
        title = "Transactions"
        navigationItem.rightBarButtonItem = editButton

        view.prepareSubviewsForAutolayout(tableView, removeButton, emptyView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: removeButton.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            removeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            removeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            removeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        removeButtonHeightConstraint = removeButton.heightAnchor.constraint(equalToConstant: 0.0)
        removeButtonHeightConstraint?.isActive = true
        view.applyFullConstraints(to: emptyView)
    }

}

// MARK: - Components creation methods
private extension RootViewController {

    func makeTableView() -> TableView {
        let tableView = TableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RootCell.self, forCellReuseIdentifier: RootCell.reuseIdentifier)
        tableView.allowsSelection = false
        tableView.allowsSelectionDuringEditing = false
        return tableView
    }

    func makeEmptyView() -> EmptyView {
        let emptyView = EmptyView()
        emptyView.tappedAddButton.addObserver(self) {
            $0.rootCoordinator?.getTransactions()
        }
        emptyView.fadeOut(with: .zero)
        return emptyView
    }

    @objc func tappedOnEdit(_ sender: Any) {
        isEdit.toggle()
    }

    func makeEditButton() -> UIBarButtonItem {
        let regularBarButtonTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: cachedStyle.color.common.itemOnBlackBG,
            .font: cachedStyle.font.common.defaultFont
        ]
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(tappedOnEdit))
        editButton.setTitleTextAttributes(regularBarButtonTextAttributes, for: .normal)
        editButton.setTitleTextAttributes(regularBarButtonTextAttributes, for: .highlighted)
        return editButton
    }

    func makeRemoveButton() -> Button {
        let removeButton = Button()
        removeButton.backgroundColor = cachedStyle.color.common.destructiveButtonBG
        removeButton.setTitle("Remove", for: .normal)
        removeButton.setTitleColor(cachedStyle.color.common.destructiveButtonText, for: .normal)
        removeButton.tapEvent.addObserver(self) {
            for index in $0.selectedIndexPath.sorted().reversed() {
                $0.transactions.remove(at: index.row)
            }
            TransactionHandler.shared.removeTransaction(ids: $0.transactions.map { $0.id }, completion: nil)
            $0.tableView.reload()
            $0.selectedIndexPath.removeAll()
        }
        return removeButton
    }

}

// MARK: - Datasource & delegate
extension RootViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if transactions.isEmpty {
            isEdit = false
            emptyView.fadeIn()
        } else {
            emptyView.fadeOut()
        }
        return transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RootCell.reuseIdentifier, for: indexPath) as? RootCell else {
            return UITableViewCell()
        }
        cell.updateCell(isSelected: false, transaction: transactions[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath.append(indexPath)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.removeButtonHeightConstraint?.constant = self.cachedStyle.dimension.common.componentDefaultSize
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedIndexPath.removeAll { $0 == indexPath }
        if selectedIndexPath.isEmpty {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.removeButtonHeightConstraint?.constant = 0.0
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }

}
