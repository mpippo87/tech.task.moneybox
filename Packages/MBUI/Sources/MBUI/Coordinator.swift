//
//  Coordinator.swift
//
//
//  Created by Filippo Minelle on 24/09/2023.
//

import UIKit.UIKitCore

protocol CoordinatorProtocol: AnyObject {

    var parentCoordinator: CoordinatorProtocol? { get set }
    var navigationController: UINavigationController { get set }

    func start()
    func start(coordinator: CoordinatorProtocol)
    func end(coordinator: CoordinatorProtocol)
    func removeChildCoordinators(removeAllChilds: Bool)
}

class Coordinator: NSObject, CoordinatorProtocol {

    // MARK: - Properties

    weak var parentCoordinator: CoordinatorProtocol?
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController = UINavigationController()

    // MARK: - Init

    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        self.navigationController.delegate = self
    }

    // MARK: - Lifecycle

    func start() {
        fatalError("\(NSStringFromClass(type(of: self))) start() method must be implemented!")
    }

    func start(coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }

    func end(coordinator: CoordinatorProtocol) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }

    func removeChildCoordinators(removeAllChilds: Bool = false) {
        if removeAllChilds {
            childCoordinators.removeAll()
            return
        }
        childCoordinators.removeAll()
    }
}

extension Coordinator: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        parentCoordinator?.removeChildCoordinators(removeAllChilds: false)
    }
}
