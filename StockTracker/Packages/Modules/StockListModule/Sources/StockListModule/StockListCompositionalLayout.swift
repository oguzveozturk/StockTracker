import UIKit

fileprivate enum Constants {
    static let height: CGFloat = 70
    static let widthRatio: CGFloat = 1.0
    static let spacing: CGFloat = 8.0
}

public final class StockListCompositionalLayout: UICollectionViewCompositionalLayout {
    
    public init() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.widthRatio),
                                              heightDimension: .estimated(Constants.height))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.widthRatio),
                                               heightDimension: .estimated(Constants.height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = Constants.spacing
        super.init(section: section)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
