import Foundation
import Combine

public protocol StockPriceViewModelProtocol {
    var uiModel: CurrentValueSubject<StockPriceUIModel?, Never> { get }
    func updateUIModel(_ newModel: StockPriceUIModel)
}

public class StockPriceViewModel: StockPriceViewModelProtocol {
    public var uiModel = CurrentValueSubject<StockPriceUIModel?, Never>(nil)
        
    public init() {}
    
    public func updateUIModel(_ newModel: StockPriceUIModel) {
        self.uiModel.send(newModel)
    }
}
