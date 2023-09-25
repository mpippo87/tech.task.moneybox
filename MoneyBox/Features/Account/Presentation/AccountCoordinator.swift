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
        let accountViewController = AccountViewController(viewModel: AccountViewModel(coordinator: self))
        navigationController.setViewControllers([accountViewController], animated: true)
        self.accountViewController = accountViewController
    }

    func goToLogin() {}

    func goToAccounts() {}
}
