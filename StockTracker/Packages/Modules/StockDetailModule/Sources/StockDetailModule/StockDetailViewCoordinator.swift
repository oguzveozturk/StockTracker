import UIKit
import Coordinator
import GraphQLClient
import Base

public protocol StockDetailViewModelRouting: Router {
    func popViewController(animated: Bool)
}

public final class StockDetailViewCoordinator: NavigationCoordinator {
    
    public var childCoordinators: [Coordinator] = []
    public var navigator: NavigatorType
    public var rootViewController: StockDetailViewController<StockDetailViewModel<StockDetailRepository, StockDetailViewCoordinator>>
    public var viewModel: StockDetailViewModel<StockDetailRepository, StockDetailViewCoordinator>
    public init(request: StockDetailRequestable, client: GraphQLClientProtocol, navigator: NavigatorType) {
        self.navigator = navigator
        let repository = StockDetailRepository(networkService: client)
        self.viewModel = .init(request: request, repository: repository)
        let stockDetailViewController = StockDetailViewController(viewModel: viewModel)
        self.rootViewController = stockDetailViewController
    }
    
    public func start() {
        viewModel.routing = self
    }
}

extension StockDetailViewCoordinator: StockDetailViewModelRouting {
    public func popViewController(animated: Bool) {
        navigator.popViewController(animated: animated)
    }
}
