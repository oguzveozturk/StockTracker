import Foundation
import CommonView
import Combine

@testable import StockDetailModule

class MockStockDetailPriceViewModel: StockPriceViewModelProtocol {
    var uiModel = CurrentValueSubject<CommonView.StockPriceUIModel?, Never>(nil)

    var invokedUpdateUIModel = false
    var invokedUpdateUIModelCount = 0
    var invokedUpdateUIModelParameters: (newModel: CommonView.StockPriceUIModel, Void)?

    func updateUIModel(_ newModel: CommonView.StockPriceUIModel) {
        invokedUpdateUIModel = true
        invokedUpdateUIModelCount += 1
        invokedUpdateUIModelParameters = (newModel, ())
    }
}
