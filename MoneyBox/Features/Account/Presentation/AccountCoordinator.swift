//
//  AccountCoordinator.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 25/09/2023.
//

import MBUI
import UIKit.UIKitCore

class AccountCoordinator: Coordinator {

    // MARK: - Properties

    // private let authService: AuthServiceProtocol
    var accountViewController: UIViewController?
    var account: Account

    // MARK: - Init

    init(
        navigationController: UINavigationController,
        account: Account
        // authService: AuthServiceProtocol = AuthService()
    ) {
//         self.authService = authService
        self.account = account
        super.init(navigationController: navigationController)
    }

    // MARK: - Lifecycle

    override func start() {
        let accountViewController = AccountViewController(viewModel: AccountViewModel(coordinator: self, account: account))
        navigationController.setViewControllers([accountViewController], animated: true)
        self.accountViewController = accountViewController
    }

    func goToLogin() {}

    func goToAccounts() {}
}
