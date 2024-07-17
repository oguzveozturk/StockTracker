import Foundation
import ApolloModels

public struct StockEntity: Hashable {
    public let name: String
    public let ticker: String
    
    public init(stock: StocksQuery.Data.Stocks.Datum) {
        self.name = stock.name
        self.ticker = stock.ticker
    }
    
    public init(name: String, ticker: String) {
        self.name = name
        self.ticker = ticker
    }
}
