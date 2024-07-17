import XCTest
import Combine
import Entity
import GraphQLClient

@testable import StockListModule

final class MockStockListRepository: StockListRepositoryProtocol {
    var invokedFetchStocks = false
    var invokedFetchStocksCount = 0
    var response: StockList?
    
    func fetchStocks(limit: Int, cursor: String?) -> AnyPublisher<StockList?, GraphQLClientError> {
        invokedFetchStocks = true
        invokedFetchStocksCount += 1

        return Just(response)
            .setFailureType(to: GraphQLClientError.self)
            .eraseToAnyPublisher()
    }
}
