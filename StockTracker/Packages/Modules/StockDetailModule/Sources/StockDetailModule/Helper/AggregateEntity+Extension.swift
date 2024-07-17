import Foundation
import Entity
import STChart

extension AggregateEntity: STLineChartDataShowable {
    
    public var xValue: Double { t }
    public var yValue: Double { c }
}
