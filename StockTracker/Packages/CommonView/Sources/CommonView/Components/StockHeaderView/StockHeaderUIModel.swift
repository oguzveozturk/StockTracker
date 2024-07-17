import Foundation

public struct StockHeaderUIModel {
    public let logoUrlString: String
    public let name: String
    
    public init(logoUrlString: String, name: String) {
        self.logoUrlString = logoUrlString
        self.name = name
    }
}
