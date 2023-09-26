//
//  AccountsCoordinator.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 25/09/2023.
//

import MBUI
import UIKit.UIKitCore

class AccountsCoordinator: Coordinator {

    // MARK: - Properties

    // private let authService: AuthServiceProtocol
    private let user: User

    // MARK: - Init

    init(
        navigationController: UINavigationController,
        user: User
        // authService: AuthServiceProtocol = AuthService()
    ) {
        self.user = user
        super.init(navigationController: navigationController)
    }

    // MARK: - Lifecycle

    override func start() {
        let accountsViewController = AccountsViewController(viewModel: AccountsViewModel(coordinator: self, user: user))
        navigationController.setViewControllers([accountsViewController], animated: true)
    }

    func goToAccount(_ account: Account) {
        let accountCoordinator = AccountCoordinator(navigationController: navigationController, account: account)
        start(coordinator: accountCoordinator)
    }
}
