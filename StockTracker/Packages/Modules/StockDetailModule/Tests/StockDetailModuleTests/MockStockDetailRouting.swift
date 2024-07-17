import XCTest
import Combine
import Entity
import GraphQLClient

@testable import StockDetailModule

final class MockStockDetailRouting: StockDetailViewModelRouting {
    var invokedPopViewController = false
    var invokedPopViewControllerCount = 0

    func popViewController(animated: Bool) {
        invokedPopViewController = true
        invokedPopViewControllerCount += 1
    }
}
