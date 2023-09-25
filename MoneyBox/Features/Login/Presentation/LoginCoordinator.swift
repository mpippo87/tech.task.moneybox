//
//  LoginCoordinator.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 24/09/2023.
//

import MBUI
import UIKit.UIKitCore

class LoginCoordinator: Coordinator {

    // MARK: - Properties

    // private let authService: AuthServiceProtocol

    var loginViewController: UIViewController?

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
        let loginViewController = LoginViewController(viewModel: LoginViewModel(coordinator: self))
        navigationController.setViewControllers([loginViewController], animated: true)
        self.loginViewController = loginViewController
    }

    func goToAccounts(_ user: User) {
        let accountsCoordinator = AccountsCoordinator(navigationController: navigationController, user: user)
        start(coordinator: accountsCoordinator)
    }
}
