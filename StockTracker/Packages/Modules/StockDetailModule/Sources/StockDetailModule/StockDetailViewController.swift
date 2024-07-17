import UIKit
import GraphQLClient
import Entity
import UIExtension
import STChart
import Base
import CommonView

fileprivate enum Constants {
    static let backgroundColor = UIColor(red: 18/255, green: 19/255, blue: 25/255, alpha: 1)
    static let stackPadding: CGFloat = 16
    static let stackSpacing: CGFloat = 10
    static let chartHeight: CGFloat = 270
}

public protocol StockDetailViewControllerProtocol: AlertShowable {
    func bindStockHeader(viewModel: StockHeaderViewModelProtocol)
    func bindStockPrice(viewModel: StockPriceViewModelProtocol)
    func bindStockInfo(viewModel: any StockInfoViewModelProtocol)
    func bindSTLineCharViewModel(viewModel: STLineChartViewModelProtocol)
}

public final class StockDetailViewController<V: StockDetailViewModelProtocol>: BaseViewController<V> {
    
    private let scrollView = UIScrollView()
    private let chartView = STLineChartView()
    private let stockHeaderView = StockHeaderView()
    private let stockInfoView = StockInfoView()
    private let stockPriceView = StockPriceView()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing
        return stackView
    }()
    
    public override func setup() {
        viewModel.view = self
    }
    
    public override func viewDidLoad() {
        view.backgroundColor = Constants.backgroundColor
        configureViews()
        viewModel.viewDidLoad()
    }
    
    private func configureViews() {
        view.addSubview(scrollView)
        scrollView.equalToSuperView()
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(stockHeaderView)
        mainStackView.addArrangedSubview(stockPriceView)
        mainStackView.addArrangedSubview(chartView)
        mainStackView.addArrangedSubview(stockInfoView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.stackPadding),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Constants.stackPadding),
            mainStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: Constants.stackPadding * -2),
            chartView.heightAnchor.constraint(equalToConstant: Constants.chartHeight),
        ])
    }
}

extension StockDetailViewController: StockDetailViewControllerProtocol {
    
    public func bindStockHeader(viewModel: any StockHeaderViewModelProtocol) {
        self.stockHeaderView.bind(to: viewModel)
    }
    
    public func bindStockInfo(viewModel: any StockInfoViewModelProtocol) {
        self.stockInfoView.bind(to: viewModel)
    }
    
    public func bindStockPrice(viewModel: any StockPriceViewModelProtocol) {
        self.stockPriceView.bind(to: viewModel)
    }

    public func bindSTLineCharViewModel(viewModel: any STChart.STLineChartViewModelProtocol) {
        self.chartView.bind(to: viewModel)
    }
}
