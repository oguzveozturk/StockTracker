import Foundation
import Combine

public protocol Repository {}

public protocol Router: AnyObject {}

public protocol BaseViewModelProtocol: AnyObject {
    associatedtype RepositoryType: Repository
    associatedtype RouterType: Router
    var repository: RepositoryType { get }
    var routing: RouterType? { get set }
        
    func viewDidLoad()
}

open class BaseViewModel<R: Repository, T: Router>: BaseViewModelProtocol {
    public let repository: R
    public weak var routing: T?
    
    public init(repository: R) {
        self.repository = repository
    }
    
    open func viewDidLoad() {}
}
