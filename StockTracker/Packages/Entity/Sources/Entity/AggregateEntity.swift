import Foundation
import ApolloModels

public struct AggregateEntity {
    public let c: Double
    public let t: Double
    
    public init(model: StockDetailQuery.Data.StockDetail.StockAggregates.Result) {
        self.c = model.c ?? 0
        self.t = model.t ?? 0
    }
    
    public init(c: Double, t: Double) {
        self.c = c
        self.t = t
    }
}
