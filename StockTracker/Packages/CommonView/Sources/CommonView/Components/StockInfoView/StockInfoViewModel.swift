import Foundation
import Combine

public protocol StockInfoViewModelProtocol {
    var uiModel: CurrentValueSubject<StockInfoUIModel?, Never> { get }
    func updateUIModel(_ newModel: StockInfoUIModel)
}

public class StockInfoViewModel: StockInfoViewModelProtocol {
    public var uiModel = CurrentValueSubject<StockInfoUIModel?, Never>(nil)
        
    public init() {}
    
    public func updateUIModel(_ newModel: StockInfoUIModel) {
        self.uiModel.send(newModel)
    }
}
