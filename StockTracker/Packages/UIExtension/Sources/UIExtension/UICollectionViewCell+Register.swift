import UIKit

public extension UICollectionView {
    func register(cellType: UICollectionViewCell.Type, bundle: Bundle) {
        register(cellType, forCellWithReuseIdentifier: String(describing: cellType))
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }
}
