import XCTest
import Combine
import Entity
import GraphQLClient

@testable import StockDetailModule

final class MockStockDetailRepository: StockDetailRepositoryProtocol {
    var invokedFetchStockDetail = false
    var invokedFetchStockDetailCount = 0
    var invokedFetchStockDetailParameters: (request: StockDetailRequestable, Void)?
    var response: StockDetail?
    
    func fetchStockDetail(with request: StockDetailRequestable) -> AnyPublisher<Entity.StockDetail?, GraphQLClientError> {
        invokedFetchStockDetail = true
        invokedFetchStockDetailCount += 1
        invokedFetchStockDetailParameters = (request, ())

        return Just(response)
            .setFailureType(to: GraphQLClientError.self)
            .eraseToAnyPublisher()
    }
}
