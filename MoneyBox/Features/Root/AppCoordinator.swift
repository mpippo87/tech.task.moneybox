//
//  AppCoordinator.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 24/09/2023.
//

import MBUI
import UIKit.UIKitCore

final class AppCoordinator: Coordinator {

    // MARK: - Properties

    // private let authService: AuthServiceProtocol
    private(set) var window: UIWindow
    private(set) var loginCoordinator: Coordinator?

    // MARK: - Init

    init(
        navigationController: UINavigationController,
        window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
        // authService: AuthServiceProtocol = AuthService(),
    ) {
        self.window = window
        // self.authService = authService
        super.init(navigationController: navigationController)
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
    }

    // MARK: - Lifecycle

    override func start() {
        goToLogin()
    }

    func goToLogin() {
        print("§ goToLogin")
        loginCoordinator = LoginCoordinator(navigationController: navigationController)
        if let loginCoordinator {
            start(coordinator: loginCoordinator)
        }
    }

    func goToAccounts() {
        print("goToAccounts")
        //        loginCoordinator = TabBarCoordinator(navigationController: navigationController, authService: authService)
        //        if let loginCoordinator {
        //            start(coordinator: loginCoordinator)
        //        }
    }
}
