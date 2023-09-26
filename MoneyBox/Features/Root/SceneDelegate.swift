//
//  SceneDelegate.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 24/09/2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties

    var window: UIWindow?
    private var coordinator: AppCoordinator?

    // MARK: - Lifecycle

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        if let window {
            coordinator = AppCoordinator(navigationController: UINavigationController(), window: window)
            coordinator?.start()
        }
    }
}
