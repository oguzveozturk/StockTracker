import Foundation
import Entity

extension StockDetail {
    static var response: StockDetail {
        StockDetail(ticker: "AAPL",
                    name: "Apple",
                    currencyName: "usd",
                    description: "description",
                    logoUrl: "logo",
                    stockAggregates: [
                        AggregateEntity(c: 10, t: 0),
                        AggregateEntity(c: 20, t: 0)]
        )
    }
    
    var closingPrice: Double {
        StockDetail.response.stockAggregates.last!.c
    }
    
    var openingPrice: Double {
        StockDetail.response.stockAggregates.first!.c
    }
    
    var change: Double {
        openingPrice.percentChange(to: closingPrice)
    }
    
    var curreny: String {
        StockDetail.response.currencyName!.currencySymbol!
    }
}
