import Combine
import UIKit

public protocol BaseComponentViewProtocol: AnyObject {
    associatedtype ViewModelType
    func setupView()
    func bind(to viewModel: ViewModelType)
}

open class BaseComponentView<V>: UIView, BaseComponentViewProtocol {
    public typealias ViewModelType = V
    
    public var cancellables = Set<AnyCancellable>()

    public init() {
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable, message: "no nibs allowed here")
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func setupView() {}

    open func bind(to viewModel: V) {}
}
