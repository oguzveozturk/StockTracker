import UIKit
import Combine

public protocol BaseViewControllerProtocol {
    associatedtype ViewModelType: BaseViewModelProtocol
    var viewModel: ViewModelType { get }
}

open class BaseViewController<V: BaseViewModelProtocol>: UIViewController, BaseViewControllerProtocol  {
    public let viewModel: V

    public init(viewModel: V) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    @available(*, unavailable, message: "nibs are not allowed here")
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    open func setup() {}

}
