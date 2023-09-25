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
    var accountsViewController: UIViewController?

    // MARK: - Init

    init(
        navigationController: UINavigationController,
        boolean: Bool = false
        // authService: AuthServiceProtocol = AuthService()
    ) {
        // self.authService = authService
        super.init(navigationController: navigationController)
    }

    // MARK: - Lifecycle

    override func start() {
        let accountsViewController = AccountsViewController(viewModel: AccountsViewModel(coordinator: self))
        navigationController.setViewControllers([accountsViewController], animated: true)
        self.accountsViewController = accountsViewController
    }

    func goToAccount() {}
}
