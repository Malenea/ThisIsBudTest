//
//  RootCoordinator.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Init and initial methods
final class RootCoordinator: Coordinator {

    // MARK: - Coordinators and navigation controller
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    // MARK: - Items
    public let onTransactionsUpdated = TriggeredEvent<[Transaction]>()

    // MARK: - Start function
    func start() {
        let vc = RootViewController()
        vc.rootCoordinator = self

        /// Getting transactions
        getTransactions()

        /// Navigation bar setup
        navigationController.navigationBar.barTintColor = .black
        navigationController.navigationBar.titleTextAttributes = [
            .foregroundColor: ColorStyle().common.itemOnBlackBG,
            .font: FontStyle().common.subTitleBoldFont
        ]

        navigationController.pushViewController(vc, animated: false)
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

}

extension RootCoordinator {

    func getTransactions() {
        TransactionHandler.shared.getTransactions { [weak self] transactions in
            self?.onTransactionsUpdated.trigger(transactions)
        }
    }
}
