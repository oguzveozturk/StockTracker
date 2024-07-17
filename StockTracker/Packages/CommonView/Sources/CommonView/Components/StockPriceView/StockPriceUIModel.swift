import UIKit

public struct StockPriceUIModel {
    public let price: String
    public let change: String
    public let changeColor: UIColor
    
    public init(price: String, change: String, changeColor: UIColor) {
        self.price = price
        self.change = change
        self.changeColor = changeColor
    }
}
