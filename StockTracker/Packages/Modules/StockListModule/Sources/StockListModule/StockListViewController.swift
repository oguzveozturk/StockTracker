import UIKit
import GraphQLClient
import Entity
import UIExtension
import Base
import CommonView

public typealias ListItemDataSource =  UICollectionViewDiffableDataSource<Section, ListItem>
typealias ListItemSnapshot = NSDiffableDataSourceSnapshot<Section, ListItem>

public protocol StockListViewControllerProtocol: AlertShowable {
    func createDataSource() -> ListItemDataSource
    func hideIndicator()
    func setEmptyMessage(text: String)
    func setTitle(_ title: String)
    func showIndicator()    
}

public final class StockListViewController<V: StockListViewModelProtocol>: BaseViewController<V>, StockListViewControllerProtocol, UICollectionViewDelegate, UIScrollViewDelegate {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds,
                                              collectionViewLayout: StockListCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(cellType: StockListCell.self,
                                bundle: .init(for: Self.self))
        collectionView.addLoadMoreActivity()
        collectionView.delegate = self
        return collectionView
    }()

    public override func setup() {
        viewModel.view = self
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
    }

    public func createDataSource() -> ListItemDataSource {
        ListItemDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .stock(let item):
                let cell = collectionView.dequeueReusableCell(with: StockListCell.self, for: indexPath)
                let uiModel = StockListCellUIModel(title: item.ticker, description: item.name)
                let cellVM = StockListCellViewModel(view: cell, uiModel: uiModel)
                cell.viewModel = cellVM
                return cell
            }
        }
    }
    
    public func hideIndicator() {
        collectionView.stopLoadMore()
    }
    
    public func setEmptyMessage(text: String) {}
    
    public func setTitle(_ title: String) {
        self.title = title
    }
    
    public func showIndicator() {
        collectionView.startLoadMore()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectStock(at: indexPath)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewModel.scrollViewDidScroll(contentOffsetY: scrollView.contentOffset.y,
                                      contentHeight: scrollView.contentSize.height,
                                      height: scrollView.frame.size.height)
    }
}
