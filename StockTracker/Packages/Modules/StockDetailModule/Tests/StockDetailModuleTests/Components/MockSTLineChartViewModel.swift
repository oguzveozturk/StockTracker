import Foundation
import CommonView
import Combine
import STChart
import Entity

@testable import StockDetailModule

class MockSTLineChartViewModel: STLineChartViewModelProtocol {
    var chartData = CurrentValueSubject<[STLineChartDataShowable], Never>([])

    var invokedLoadChart = false
    var invokedLoadChartCount = 0
    var invokedLoadChartParameters: (data: [STLineChartDataShowable], Void)?

    var theme = CurrentValueSubject<ChartTheme, Never>(.green)

    var selectedPrice = CurrentValueSubject<Double?, Never>(nil)

    func loadChart(data: [any STLineChartDataShowable]) {
        invokedLoadChart = true
        invokedLoadChartCount += 1
        invokedLoadChartParameters = (data, ())
        selectedPrice.send(data.last?.yValue)
    }

    func updateChartTheme(theme: ChartTheme) {}
}

struct MockSTLineChartData: STLineChartDataShowable {
    var xValue: Double { 0 }
    
    var yValue: Double { 0 }
}
