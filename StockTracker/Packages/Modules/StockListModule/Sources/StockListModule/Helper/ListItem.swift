import Entity
import Foundation

public enum ListItem: Hashable {
    case stock(StockEntity)
}

public enum Section {
    case main
}

public extension Array where Element == StockEntity {
    func toItems() -> [ListItem] {
        map { ListItem.stock($0) }
    }
}
