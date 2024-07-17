import Foundation

extension DateFormatter {
    static let shared = DateFormatter()
}

public extension Date {
    static var yesterday: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    }
    
    func formatTo(_ format: String) -> String {
        let formatter = DateFormatter.shared
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    var yyyyMMdd: String {
        formatTo("yyyy-MM-dd")
    }
    
    var HHmm: String {
        formatTo("HH:mm")
    }
}
