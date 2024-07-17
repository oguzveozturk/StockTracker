import Foundation
import Combine
import GraphQLClient
import Entity
import StockDetailModule
import Base
import CommonView

public protocol StockListViewModelProtocol: BaseViewModelProtocol {
    var view: StockListViewControllerProtocol? { get set }
    func scrollViewDidScroll(contentOffsetY: CGFloat, contentHeight: CGFloat, height: CGFloat)
    func selectStock(at index: IndexPath)
}

fileprivate enum Constants {
    static let title = "Stocks"
    static let limit = 30
}

public final class StockListViewModel<R: StockListRepositoryProtocol, T: StockListViewModelRouting>: BaseViewModel<R,T> {
    public weak var view: StockListViewControllerProtocol?
    private var dataSource: ListItemDataSource?
    private var cancellable = Set<AnyCancellable>()
    private var cursor: String?
    
    enum ListState {
        case idle, loading, stop
    }
    
    private var listState = ListState.idle {
        didSet {
            configureState()
        }
    }

    public override init(repository: R){
        super.init(repository: repository)
    }
    
    public override func viewDidLoad() {
        view?.setTitle(Constants.title)
        configureDataSource()
        fetchStocks()
        applyInitialSnapshot()
    }
    
    private func configureDataSource() {
        dataSource = view?.createDataSource()
    }
    
    private func fetchStocks() {
        repository.fetchStocks(limit: Constants.limit, cursor: cursor)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.showError(error)
                }
            } receiveValue: { [weak self] stockReponse in
                guard let stockReponse else { return }
                self?.handleResponse(stockReponse)
            }.store(in: &cancellable)
    }
    
    private func handleResponse(_ stockReponse: StockList) {
        checkHasMore(stockReponse.hasMore)
        updateCursor(stockReponse.cursor)
        addItems(stockReponse.stocks.toItems())
    }
    
    private func checkHasMore(_ hasMore: Bool) {
        listState = hasMore ? .idle : .stop
    }
    
    private func configureState() {
        switch listState {
        case .idle, .stop:
            view?.hideIndicator()
        case .loading:
            view?.showIndicator()
        }
    }
    
    private func updateCursor(_ cursor: String?) {
        self.cursor = cursor
    }
    
    private func showError(_ error: Error) {
        view?.showBasicAlert(error.localizedDescription) { [weak self] in
            self?.listState = .idle
        }
    }
    
    private func applyInitialSnapshot() {
        var snapshot = ListItemSnapshot()
        snapshot.appendSections([.main])
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    private func addItems(_ items: [ListItem]) {
        guard var snapshot = dataSource?.snapshot() else { return }
        let uniqueItems = items.filter { listItem in
            !snapshot.itemIdentifiers.contains(listItem)
        }
        snapshot.appendItems(uniqueItems, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension StockListViewModel: StockListViewModelProtocol {
    public func selectStock(at index: IndexPath) {
        if let item = dataSource?.itemIdentifier(for: index) {
            switch item {
            case .stock(let stockEntity):
                let request = StockDetailRequestModel.caseDefault(ticker: stockEntity.ticker)
                routing?.navigateToDetail(request: request)
            }
        }
    }
    
    public func scrollViewDidScroll(contentOffsetY: CGFloat, contentHeight: CGFloat, height: CGFloat) {
        let isReachingEnd = contentOffsetY >= .zero && contentOffsetY >= (contentHeight - height)
        if isReachingEnd && listState == .idle {
            listState = .loading
            fetchStocks()
        }
    }
}
