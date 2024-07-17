import Foundation
import STChart

extension ChartTheme {
    
    public init(_ sign: FloatingPointSign) {
        switch sign {
        case .plus:
            self = .green
        case .minus:
            self = .orange
        }
    }
}
