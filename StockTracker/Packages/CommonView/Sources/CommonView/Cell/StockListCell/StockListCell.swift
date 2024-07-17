import UIKit
import Base
import Combine

fileprivate enum Constants {
    static let padding: UIEdgeInsets = .init(top: 16, left: 16, bottom: 16, right: 16)
    static let titleDescriptionSpacing: CGFloat = 8
    static let disclosureImageViewHeight: CGFloat = 20
    static let disclosureImageViewWidth: CGFloat = 12
    static let disclosureImageViewTrailing: CGFloat = -16
    static let mainStackViewLeading: CGFloat = 16
    static let mainStackViewTrailing: CGFloat = -8
    static let separatorHeight: CGFloat = 1
    static let disclosureImage = "chevron.right"
}

public protocol StockListCellViewProtocol: AnyObject {
    func setupViews()
    func setTitleLabel(text: String)
    func setDescriptionLabel(text: String)
}

public class StockListCell: UICollectionViewCell {
    public weak var viewModel: (StockListCellViewModelProtocol)? {
        didSet {
            viewModel?.load()
        }
    }
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    public let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.numberOfLines = .zero
        return label
    }()
    
    public lazy var disclosureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.disclosureImage)
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    public lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, separator])
        stackView.axis = .vertical
        stackView.spacing = Constants.titleDescriptionSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
        
    public func setupViews() {
        contentView.addSubview(disclosureImageView)
        NSLayoutConstraint.activate([
            disclosureImageView.heightAnchor.constraint(equalToConstant: Constants.disclosureImageViewHeight),
            disclosureImageView.widthAnchor.constraint(equalToConstant: Constants.disclosureImageViewWidth),
            disclosureImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            disclosureImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.disclosureImageViewTrailing)
        ])
        
        contentView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.mainStackViewLeading),
            mainStackView.trailingAnchor.constraint(equalTo: disclosureImageView.leadingAnchor, constant: Constants.mainStackViewTrailing),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: Constants.separatorHeight)
        ])
    }
}

extension StockListCell: StockListCellViewProtocol {
    public func setTitleLabel(text: String) {
        titleLabel.text = text
    }
    
    public func setDescriptionLabel(text: String) {
        descriptionLabel.text = text
    }
}
