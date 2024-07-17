import UIKit

public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

public extension Coordinator {
    
    func addChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators.append(childCoordinator)
    }
    
    func removeChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}

public protocol _PresentationCoordinator: Coordinator {
    var _rootViewController: UIViewController { get }
}

public protocol PresentationCoordinator: _PresentationCoordinator {
    associatedtype ViewController: UIViewController
    var rootViewController: ViewController { get }
}

public extension PresentationCoordinator {
    
    var _rootViewController: UIViewController { return rootViewController }
}

public extension PresentationCoordinator {

    func presentCoordinator(_ childCoordinator: _PresentationCoordinator, animated: Bool) {
        addChildCoordinator(childCoordinator)
        childCoordinator.start()
        rootViewController.present(childCoordinator._rootViewController, animated: animated)
    }
    
    func dismissCoordinator(_ childCoordinator: _PresentationCoordinator, animated: Bool, completion: (() -> Void)? = nil) {
        childCoordinator._rootViewController.dismiss(animated: animated, completion: completion)
        self.removeChildCoordinator(childCoordinator)
    }

}

public protocol NavigationCoordinator: PresentationCoordinator {
    var navigator: NavigatorType { get }
}

public extension NavigationCoordinator {

    func pushCoordinator(_ childCoordinator: _PresentationCoordinator, animated: Bool) {
        addChildCoordinator(childCoordinator)
        childCoordinator.start()
        navigator.push(childCoordinator._rootViewController,
                       animated: animated,
                       onPoppedCompletion: { [weak self] in
                        self?.removeChildCoordinator(childCoordinator)
        })
    }
}
