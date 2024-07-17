import Foundation
import DGCharts
import Extension

public protocol STLineChartDataShowable {
    var xValue: Double { get }
    var yValue: Double { get }
}

extension ChartDataEntry {
    public convenience init(_ stLineData: STLineChartDataShowable) {
        let date = Date(timeIntervalSince1970: stLineData.xValue / 1000).HHmm
        self.init(x: stLineData.xValue, y: stLineData.yValue, data: date)
    }
}

extension LineChartData {
    public convenience init(data: [any STLineChartDataShowable]) {
        let chartDatas = data.entries.dataSets
        self.init(dataSets: chartDatas)
    }
}

public extension Array where Element == STLineChartDataShowable {
    var entries: [ChartDataEntry] {
        map(ChartDataEntry.init)
    }
}

public extension Array where Element == ChartDataEntry {
    var dataSets: [LineChartDataSet] {
        map { _ in
            let dataSet = LineChartDataSet(entries: self, label: "")
            dataSet.drawValuesEnabled = false
            dataSet.drawCirclesEnabled = false
            dataSet.drawHorizontalHighlightIndicatorEnabled = false
            return dataSet
        }
    }
}
