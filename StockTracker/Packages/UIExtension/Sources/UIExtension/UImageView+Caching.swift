import UIKit
import Kingfisher

extension UIImageView {
    public func setImage(_ url: URL?, placeholder: UIImage? = nil) {
        kf.setImage(with: url, placeholder: placeholder)
    }
}
