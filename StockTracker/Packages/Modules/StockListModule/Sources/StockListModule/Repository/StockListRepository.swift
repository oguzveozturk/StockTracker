import Foundation
import ApolloModels
import Entity
import Base
import Combine
import GraphQLClient

public protocol StockListRepositoryProtocol: Repository {
    func fetchStocks(limit: Int, cursor: String?) -> AnyPublisher<StockList?, GraphQLClientError>
}

public final class StockListRepository {
    private let networkService: GraphQLClientProtocol
    
    public init(networkService: GraphQLClientProtocol) {
        self.networkService = networkService
    }
}

extension StockListRepository: StockListRepositoryProtocol {
    public func fetchStocks(limit: Int, cursor: String?) -> AnyPublisher<StockList?, GraphQLClientError> {
        networkService
            .request(for: StocksQuery(limit: .some(limit), cursor: .some(cursor ?? "")),
                     cachePolicy: .returnCacheDataElseFetch)
            .map { StockList(stocks: $0.stocks) }
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
