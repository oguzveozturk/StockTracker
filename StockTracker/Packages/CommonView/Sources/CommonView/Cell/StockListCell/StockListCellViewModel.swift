import Foundation
import Combine

public protocol StockListCellViewModelProtocol: AnyObject {
    func load()
}

public class StockListCellViewModel: StockListCellViewModelProtocol {
    private weak var view: StockListCellViewProtocol?
    private let uiModel: StockListCellUIModel

    public init(view: StockListCellViewProtocol, uiModel: StockListCellUIModel) {
        self.view = view
        self.uiModel = uiModel
    }
    
    public func load() {
        view?.setupViews()
        view?.setTitleLabel(text: uiModel.title)
        view?.setDescriptionLabel(text: uiModel.description)
    }
}
