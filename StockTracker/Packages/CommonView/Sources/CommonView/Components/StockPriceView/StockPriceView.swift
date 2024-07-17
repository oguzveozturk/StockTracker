import UIKit
import Combine
import Base
import Combine

fileprivate enum Constants {
    static let logoSize: CGFloat = 32
    static let horizontalSpacing: CGFloat = 8
    static let priceLabelColor: UIColor = .white
}

public final class StockPriceView: BaseComponentView<StockPriceViewModelProtocol> {

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.textColor = Constants.priceLabelColor
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()

    private let changeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.horizontalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    public override func setupView() {
        addSubview(horizontalStackView)
        horizontalStackView.equalToSuperView()
        horizontalStackView.addArrangedSubview(priceLabel)
        horizontalStackView.addArrangedSubview(changeLabel)
        let leadingPadding = Constants.horizontalSpacing + Constants.logoSize
        horizontalStackView.layoutMargins = UIEdgeInsets(top: 0, left: leadingPadding, bottom: 0, right: 0)
        horizontalStackView.isLayoutMarginsRelativeArrangement = true
    }
    
   public override func bind(to viewModel: StockPriceViewModelProtocol) {
        viewModel.uiModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] uiModel in
                self?.priceLabel.text = uiModel?.price
                self?.changeLabel.text = uiModel?.change
                self?.changeLabel.textColor = uiModel?.changeColor
            }
            .store(in: &cancellables)
    }
}
