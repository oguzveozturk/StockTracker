import Foundation
import Combine
import Entity
import Extension
import STChart
import Base
import CommonView

public protocol StockDetailViewModelProtocol: BaseViewModelProtocol {
    var view: StockDetailViewControllerProtocol? { get set }
}

public final class StockDetailViewModel<R: StockDetailRepositoryProtocol, T: StockDetailViewModelRouting>: BaseViewModel<R, T>, StockDetailViewModelProtocol {
    
    public weak var view: (any StockDetailViewControllerProtocol)?
    private var cancellable = Set<AnyCancellable>()
    var stockDetail: StockDetail!
    private var stockHeaderViewModel: StockHeaderViewModelProtocol
    private var stockInfoViewModel: StockInfoViewModelProtocol
    private var stockPriceViewModel: StockPriceViewModelProtocol
    private var stLineChartViewModel: STLineChartViewModelProtocol
    private let request: StockDetailRequestable
        
    public init(request: StockDetailRequestable,
                repository: R,
                stockHeaderViewModel: StockHeaderViewModelProtocol = StockHeaderViewModel(),
                stockInfoViewModel: StockInfoViewModelProtocol = StockInfoViewModel(),
                stockPriceViewModel: StockPriceViewModelProtocol = StockPriceViewModel(),
                stLineChartViewModel: STLineChartViewModelProtocol = STLineChartViewModel()) {
        self.request = request
        self.stockHeaderViewModel = stockHeaderViewModel
        self.stockPriceViewModel = stockPriceViewModel
        self.stockInfoViewModel = stockInfoViewModel
        self.stLineChartViewModel = stLineChartViewModel
        super.init(repository: repository)
    }
    
    public override func viewDidLoad() {
        makeBindings()

        repository.fetchStockDetail(with: request)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.showErrorAndPop(error)
                }
            } receiveValue: { [weak self] stockReponse in
                guard let stockReponse else { return }
                self?.stockDetail = stockReponse
                self?.handleResponse()
            }.store(in: &cancellable)
        
        stLineChartViewModel.selectedPrice
            .sink { [weak self] price in
                if let price,
                let change = self?.calculateChange(price: price) {
                    self?.updateStockPrice(price: price, change: change)
                    self?.updateChartTheme(sign: change.sign)
                }
            }.store(in: &cancellable)
    }
    
    private func handleResponse() {
        updateChartData()
        updateStockHeader()
        updateStockInfo()
    }
    
    private func updateStockHeader() {
        let stockHeaderUIModel = StockHeaderUIModel(logoUrlString: stockDetail.logoUrl,
                                                    name: stockDetail.name)
        self.stockHeaderViewModel.updateUIModel(stockHeaderUIModel)
    }
    
    private func updateStockInfo() {
        let stockInfoUIModel = StockInfoUIModel(description: stockDetail.description)
        stockInfoViewModel.updateUIModel(stockInfoUIModel)
        
    }

    private func updateChartData() {
        let aggregates = stockDetail.stockAggregates
        stLineChartViewModel.loadChart(data: aggregates)
    }
    
    private func updateStockPrice(price: Double, change: Double) {
        let theme: ChartTheme = .init(change.sign)
        let changeString = change.toString()
        let symbol = stockDetail.currencyName?.currencySymbol ?? ""
        
        let stockPriceUIModel = StockPriceUIModel(price: "\(symbol)\(price.toString())",
                                                  change: "%\(changeString)",
                                                  changeColor: theme.color)
        stockPriceViewModel.updateUIModel(stockPriceUIModel)
    }
    
    private func updateChartTheme(sign: FloatingPointSign) {
        stLineChartViewModel.updateChartTheme(theme: .init(sign))
    }
    
    private func calculateChange(price: Double) -> Double? {
        let openingPrice = stockDetail.stockAggregates.first?.c
        return openingPrice?.percentChange(to: price)
    }
    
    private func makeBindings() {
        view?.bindStockHeader(viewModel: stockHeaderViewModel)
        view?.bindStockPrice(viewModel: stockPriceViewModel)
        view?.bindStockInfo(viewModel: stockInfoViewModel)
        view?.bindSTLineCharViewModel(viewModel: stLineChartViewModel)
    }
    
    private func showErrorAndPop(_ error: Error) {
        view?.showBasicAlert(error.localizedDescription) { [weak self] in
            self?.routing?.popViewController(animated: true)
        }
    }
}
