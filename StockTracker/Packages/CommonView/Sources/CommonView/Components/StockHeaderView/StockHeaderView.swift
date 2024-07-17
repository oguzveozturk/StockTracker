import UIKit
import UIExtension
import Combine
import Extension
import Base

fileprivate enum Constants {
    static let logoSize: CGFloat = 32
    static let horizontalSpacing: CGFloat = 8
    static let placeHolderName = "exclamationmark.triangle"
}

public final class StockHeaderView: BaseComponentView<StockHeaderViewModelProtocol> {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .white
        label.numberOfLines = .zero
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()

    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = Constants.horizontalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    public override func setupView() {
        addSubview(horizontalStackView)
        horizontalStackView.equalToSuperView()
        horizontalStackView.addArrangedSubview(logoImageView)
        horizontalStackView.addArrangedSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: Constants.logoSize),
            logoImageView.heightAnchor.constraint(equalToConstant: Constants.logoSize)
        ])
    }
    
    public override func bind(to viewModel: StockHeaderViewModelProtocol) {
        viewModel.uiModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] uiModel in
                self?.logoImageView.setImage(uiModel?.logoUrlString.asURL, placeholder: UIImage(systemName: Constants.placeHolderName))
                self?.nameLabel.text = uiModel?.name
            }
            .store(in: &cancellables)
    }
}
