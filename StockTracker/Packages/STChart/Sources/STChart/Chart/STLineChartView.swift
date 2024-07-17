import UIKit
import DGCharts
import UIExtension
import Combine

fileprivate enum Constants {
    static let chartInset: UIEdgeInsets = .init(top: 30, left: 0, bottom: 30, right: 0)
    static let timeLabelBottomSpace: CGFloat = -5
}

public protocol STChartViewProtocol: AnyObject {
    func bind(to viewModel: STLineChartViewModelProtocol)
}

public final class STLineChartView: UIView {
    private let chart = LineChartView()
    private let circleMarker = PointMarker()
    private let timeLabel = UILabel()
    private var cancellable = Set<AnyCancellable>()
    private lazy var timeLabelXConstraint = NSLayoutConstraint()
    private var viewModel: STLineChartViewModelProtocol?
    
    public init() {
        super.init(frame: .zero)
        configureChartView()
        configureTimeLabel()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateMarkerColor(_ color: UIColor) {
        circleMarker.updateFillColor(color)
    }
    
    private func updateChartData(_ data: LineChartData) {
        chart.data = data
        chart.addHorizontalLimitLine()
        chart.notifyDataSetChanged()
    }
    
    public func updateChartColors(_ color: UIColor) {
        guard let data = chart.data else { return }
        for case let dataSet as LineChartDataSet in data.dataSets {
            dataSet.setColor(color)
            dataSet.highlightColor = color
        }
        chart.notifyDataSetChanged()
    }
}

extension STLineChartView: ChartViewDelegate {
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        timeLabel.text = entry.data as? String
        timeLabelXConstraint.constant = highlight.xPx
        timeLabel.isHidden = false
        viewModel?.selectedPrice.send(entry.y)
    }
    
    public func chartValueNothingSelected(_ chartView: ChartViewBase) {
        timeLabel.isHidden = true
    }
}

extension STLineChartView: STChartViewProtocol {
    public func bind(to viewModel: STLineChartViewModelProtocol) {
        self.viewModel = viewModel
        
        viewModel.chartData.sink { [weak self] chartData in
            self?.updateChartData(.init(data: chartData))
        }.store(in: &cancellable)
        
        viewModel.theme
            .sink { [weak self] theme in
            self?.updateChartColors(theme.color)
            self?.updateMarkerColor(theme.color)
        }.store(in: &cancellable)
    }
}

extension STLineChartView {
    private func configureChartView() {
        addSubview(chart)
        chart.equalToSuperView(padding: Constants.chartInset)
        chart.applyStockDetailStyle()
        chart.delegate = self
        circleMarker.chartView = chart
        chart.marker = circleMarker
    }
    
    private func configureTimeLabel() {
        chart.addSubview(timeLabel)
        timeLabel.isHidden = true
        timeLabel.textColor = .lightGray
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabelXConstraint = timeLabel.centerXAnchor.constraint(equalTo: chart.leadingAnchor)
        NSLayoutConstraint.activate( [
            timeLabel.bottomAnchor.constraint(equalTo: chart.topAnchor, constant: Constants.timeLabelBottomSpace),
            timeLabelXConstraint
        ])
    }
}
