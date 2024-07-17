import UIKit
import DGCharts

extension LineChartView {
    public func applyStockDetailStyle() {
        xAxis.drawGridLinesEnabled = false
        leftAxis.drawGridLinesEnabled = false
        rightAxis.drawGridLinesEnabled = false
        xAxis.drawLabelsEnabled = false
        leftAxis.drawLabelsEnabled = false
        rightAxis.drawLabelsEnabled = false
        legend.enabled = false
        pinchZoomEnabled = false
        doubleTapToZoomEnabled = false
        xAxis.enabled = false
        leftAxis.enabled = false
        rightAxis.enabled = false
        minOffset = 0
    }
    
    public func addHorizontalLimitLine() {
        guard let dataSet = data?.dataSets.first as? LineChartDataSet,
              let firstEntry = dataSet.entries.first else { return }
        
        let firstYValue = firstEntry.y
        let limitLine = ChartLimitLine(limit: firstYValue, label: "")
        limitLine.lineWidth = 2
        limitLine.lineDashLengths = [4, 4]
        limitLine.lineColor = .systemGray
        leftAxis.drawLimitLinesBehindDataEnabled = true
        leftAxis.enabled = true
        leftAxis.drawLabelsEnabled = false
        leftAxis.drawGridLinesEnabled = false
        leftAxis.drawAxisLineEnabled = false
        leftAxis.addLimitLine(limitLine)
    }
}
