import Foundation
@testable import StockDetailModule

struct MockStockDetailRequest: StockDetailRequestable {
    var ticker: String = "AAPL"
    var limit: Int = 1000
    var endDate: Date = Date.yesterday
    var startDate: Date = Date.yesterday
    var range: Int = 5
    var timespan: String = "minute"
}
