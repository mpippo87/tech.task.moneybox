//
//  LoginCoordinator.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 24/09/2023.
//

import MBUI
import UIKit.UIKitCore

final class LoginCoordinator: Coordinator {

    // MARK: - Properties

    var loginViewController: UIViewController?

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
