import Foundation
import DGCharts
import Combine
import Extension

public protocol STLineChartViewModelProtocol {
    var chartData: CurrentValueSubject<[STLineChartDataShowable], Never> { get set }
    var theme: CurrentValueSubject<ChartTheme, Never> { get set }
    var selectedPrice: CurrentValueSubject<Double?, Never> { get set }
    func loadChart(data: [any STLineChartDataShowable])
    func updateChartTheme(theme: ChartTheme)
}

public final class STLineChartViewModel {
    public var theme = CurrentValueSubject<ChartTheme, Never>(.green)
    public var chartData = CurrentValueSubject<[STLineChartDataShowable], Never>([])
    public var selectedPrice = CurrentValueSubject<Double?, Never>(nil)
    
    public init() {}
}

extension STLineChartViewModel: STLineChartViewModelProtocol {
    public func updateChartTheme(theme: ChartTheme) {
        self.theme.send(theme)
    }
    
    public func loadChart(data: [any STLineChartDataShowable]) {
        self.chartData.send(data)
        self.selectedPrice.send(data.last?.yValue)
    }
}
