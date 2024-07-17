import UIKit

public protocol AlertShowable: AnyObject {
    func showBasicAlert(_ message: String, completion: (() -> Void)?)
}

extension AlertShowable where Self: UIViewController {
    public func showBasicAlert(_ message: String, completion: (() -> Void)? = nil) {
       let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: "Ok", style: .default, handler: { _ in
            completion?()
        }))
       DispatchQueue.main.async {
           self.present(alertController, animated: true)
       }
   }
}
