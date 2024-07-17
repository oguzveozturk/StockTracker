import Foundation
import Combine

public protocol StockHeaderViewModelProtocol {
    var uiModel: CurrentValueSubject<StockHeaderUIModel?, Never> { get }
    func updateUIModel(_ newModel: StockHeaderUIModel)
}

public class StockHeaderViewModel: StockHeaderViewModelProtocol {
    public var uiModel = CurrentValueSubject<StockHeaderUIModel?, Never>(nil)

    public init() {}
    
    public func updateUIModel(_ newModel: StockHeaderUIModel) {
        self.uiModel.send(newModel)
    }
}
