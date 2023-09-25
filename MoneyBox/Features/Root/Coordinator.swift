//
//  Coordinator.swift
//
//
//  Created by Filippo Minelle on 24/09/2023.
//

import UIKit.UIKitCore

public protocol CoordinatorProtocol: AnyObject {

    var parentCoordinator: CoordinatorProtocol? { get set }
    var navigationController: UINavigationController { get set }

    func start()
    func start(coordinator: CoordinatorProtocol)
    func end(coordinator: CoordinatorProtocol)
    func removeChildCoordinators(removeAllChilds: Bool)
}

public class Coordinator: NSObject, CoordinatorProtocol {

    // MARK: - Properties

    public weak var parentCoordinator: CoordinatorProtocol?
    public var childCoordinators: [CoordinatorProtocol] = []
    public var navigationController = UINavigationController()

    // MARK: - Init

    public init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        self.navigationController.delegate = self
    }

    // MARK: - Lifecycle

    public func start() {
        fatalError("\(NSStringFromClass(type(of: self))) start() method must be implemented!")
    }

    public func start(coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }

    public func end(coordinator: CoordinatorProtocol) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }

    public func removeChildCoordinators(removeAllChilds: Bool = false) {
        if removeAllChilds {
            childCoordinators.removeAll()
            return
        }
        childCoordinators.removeAll()
    }
}

extension Coordinator: UINavigationControllerDelegate {

    public func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        parentCoordinator?.removeChildCoordinators(removeAllChilds: false)
    }
}
