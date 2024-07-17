import Foundation

extension Double {
    public func toString() -> String {
        String(format: "%.2f", self)
    }
    
    public func percentChange(to newValue: Double) -> Double {
        ((newValue - self) / self) * 100
    }
}
