import UIKit
import Refreshable

public extension UICollectionView {
    func addPullActivity() {
        addPullToRefresh{}
    }
    
    func addLoadMoreActivity() {
        addLoadMore {}
    }
    
    func showLoadMoreActivity() {
        startLoadMore()
    }
    
    func hideLoadMoreActivity() {
        stopLoadMore()
    }
}
