import Foundation
import ApolloModels
import Entity
import GraphQLClient
import Combine
import Base

public protocol StockDetailRepositoryProtocol: Repository {
    func fetchStockDetail(with: StockDetailRequestable) -> AnyPublisher<StockDetail?, GraphQLClientError>
}

public final class StockDetailRepository {
    private let networkService: GraphQLClientProtocol
    
    public init(networkService: GraphQLClientProtocol) {
        self.networkService = networkService
    }
}

extension StockDetailRepository: StockDetailRepositoryProtocol {
    public func fetchStockDetail(with: StockDetailRequestable) -> AnyPublisher<StockDetail?, GraphQLClientError> {
        networkService
            .request(for: StockDetailQuery(model: with),
                     cachePolicy: .returnCacheDataElseFetch)
            .map { StockDetail(model: $0.stockDetail) }
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
