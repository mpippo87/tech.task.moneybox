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

    private(set) var window: UIWindow
    private(set) var loginCoordinator: Coordinator?

    // MARK: - Init

    init(
        navigationController: UINavigationController,
        window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    ) {
        self.window = window
        super.init(navigationController: navigationController)
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
    }

    // MARK: - Lifecycle

    override func start() {
        goToLogin()
    }

    func goToLogin() {
        loginCoordinator = LoginCoordinator(navigationController: navigationController)
        if let loginCoordinator {
            start(coordinator: loginCoordinator)
        }
    }
}
