import Foundation
import ApolloModels
import Extension

public protocol StockDetailRequestable {
    var ticker: String { get set }
    var limit : Int { get set }
    var endDate: Foundation.Date { get set }
    var startDate: Foundation.Date { get set }
    var range: Int { get set }
    var timespan: String { get set }
}

public struct StockDetailRequestModel: StockDetailRequestable {
    public var ticker: String
    public var limit : Int
    public var endDate: Foundation.Date
    public var startDate: Foundation.Date
    public var range: Int
    public var timespan: String
    
    public init(ticker: String, limit: Int, endDate: Foundation.Date, startDate: Foundation.Date, range: Int, timespan: String) {
        self.ticker = ticker
        self.limit = limit
        self.endDate = endDate
        self.startDate = startDate
        self.range = range
        self.timespan = timespan
    }
    
   public static func caseDefault(ticker: String) -> StockDetailRequestModel {
        .init(ticker: ticker,
              limit: 1000,
              endDate: Foundation.Date.yesterday,
              startDate: Foundation.Date.yesterday,
              range: 5,
              timespan: "minute")
    }
}

extension StockDetailQuery {
    
    public convenience init(model: StockDetailRequestable) {
        self.init(ticker: model.ticker,
                  limit: .some(model.limit),
                  endDate: .some(model.endDate.yyyyMMdd),
                  startDate: .some(model.startDate.yyyyMMdd),
                  range: .some(model.range),
                  timespan: .some(model.timespan))
    }
}
