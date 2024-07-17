import Foundation
import CommonView
import Combine

@testable import StockDetailModule

class MockStockHeaderViewModel: StockHeaderViewModelProtocol {
    var uiModel = CurrentValueSubject<CommonView.StockHeaderUIModel?, Never>(nil)

    var invokedUpdateUIModel = false
    var invokedUpdateUIModelCount = 0
    var invokedUpdateUIModelParameters: (newModel: CommonView.StockHeaderUIModel, Void)?

    func updateUIModel(_ newModel: CommonView.StockHeaderUIModel) {
        invokedUpdateUIModel = true
        invokedUpdateUIModelCount += 1
        invokedUpdateUIModelParameters = (newModel, ())
    }
}
