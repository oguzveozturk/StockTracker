import Foundation
import ApolloModels

public struct StockList: Hashable {
    public let cursor: String?
    public let hasMore: Bool
    public let stocks: [StockEntity]
    
    public init?(stocks: StocksQuery.Data.Stocks?) {
        guard let stocks else { return nil }
        self.cursor = stocks.cursor
        self.hasMore = stocks.has_more
        self.stocks = stocks.data.compactMap(StockEntity.init)
    }
    
    public init(cursor: String? = nil, hasMore: Bool, stocks: [StockEntity]) {
        self.cursor = cursor
        self.hasMore = hasMore
        self.stocks = stocks
    }
}
