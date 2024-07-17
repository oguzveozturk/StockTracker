import Entity
import StockDetailModule

@testable import StockListModule

final class MockStockListRouting: StockListViewModelRouting {
    var invokedNavigateToDetail = false
    var invokedNavigateToDetailCount = 0
    var invokedNavigateToDetailParameters: (request: StockDetailRequestable, Void)?
    var invokedNavigateToDetailParametersList = [(request: StockDetailRequestable, Void)]()

    func navigateToDetail(request: StockDetailRequestable) {
        invokedNavigateToDetail = true
        invokedNavigateToDetailCount += 1
        invokedNavigateToDetailParameters = (request, ())
        invokedNavigateToDetailParametersList.append((request, ()))
    }
}
