import Foundation
import ApolloModels

public struct StockDetail {
    public let ticker: String
    public let name: String
    public let currencyName: String?
    public let description: String?
    public let logoUrl: String
    public let stockAggregates: [AggregateEntity]
    
    public init?(model: StockDetailQuery.Data.StockDetail?) {
        guard let model else { return nil }
        self.ticker = model.ticker
        self.name = model.name
        self.currencyName = model.currency_name
        self.description = model.description
        self.logoUrl = model.branding?.logo_url ?? ""
        let results = model.stockAggregates.flatMap { $0.results?.compactMap { $0 }} ?? []
        self.stockAggregates = results.compactMap(AggregateEntity.init)
    }
    
    public init(ticker: String, name: String, currencyName: String? = nil, description: String? = nil, logoUrl: String, stockAggregates: [AggregateEntity]) {
        self.ticker = ticker
        self.name = name
        self.currencyName = currencyName
        self.description = description
        self.logoUrl = logoUrl
        self.stockAggregates = stockAggregates
    }
}
