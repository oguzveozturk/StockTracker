import UIKit
import Coordinator
import GraphQLClient
import StockDetailModule
import Base

public protocol StockListViewModelRouting: Router {
    func navigateToDetail(request: StockDetailRequestable)
}

public final class StockListViewCoordinator: NavigationCoordinator {
    
    public var childCoordinators: [Coordinator] = []
    public var navigator: NavigatorType
    public var rootViewController: UINavigationController
    private var viewModel: StockListViewModel<StockListRepository, StockListViewCoordinator>
    private let client: GraphQLClientProtocol
    
    public init(client: GraphQLClientProtocol) {
        self.client = client
        let repository = StockListRepository(networkService: client)
        viewModel = .init(repository: repository)

        let stockListViewController = StockListViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: stockListViewController)
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }
    
    public func start() {
        viewModel.routing = self
    }
}

extension StockListViewCoordinator: StockListViewModelRouting {
    public func navigateToDetail(request: StockDetailRequestable) {
        let coordinator = StockDetailViewCoordinator(request: request, client: client, navigator: navigator)
        pushCoordinator(coordinator, animated: true)
    }
}
