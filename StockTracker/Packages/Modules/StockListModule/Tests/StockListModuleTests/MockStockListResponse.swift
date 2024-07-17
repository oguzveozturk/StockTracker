
import Foundation
import Entity

extension StockList {
    static var response: StockList {
        StockList(hasMore: true, stocks: [.init(name: "Apple", ticker: "AAPL")])
    }
}
