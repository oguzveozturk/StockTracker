import Foundation
import CommonView
import Combine

@testable import StockDetailModule

class MockStockInfoViewModel: StockInfoViewModelProtocol {
    var uiModel = CurrentValueSubject<CommonView.StockInfoUIModel?, Never>(nil)

    var invokedUpdateUIModel = false
    var invokedUpdateUIModelCount = 0
    var invokedUpdateUIModelParameters: (newModel: CommonView.StockInfoUIModel, Void)?

    func updateUIModel(_ newModel: CommonView.StockInfoUIModel) {
        invokedUpdateUIModel = true
        invokedUpdateUIModelCount += 1
        invokedUpdateUIModelParameters = (newModel, ())
    }
}
