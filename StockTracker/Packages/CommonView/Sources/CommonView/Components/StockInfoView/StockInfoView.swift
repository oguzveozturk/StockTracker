import UIKit
import Combine
import Base

fileprivate enum Constants {
    static let verticalSpacing: CGFloat = 8
    static let titleText = "Info"
    static let titleLabelColor: UIColor = .systemGray6
    static let descriptionLabelColor: UIColor = .systemGray6
}

public final class StockInfoView: BaseComponentView<StockInfoViewModelProtocol> {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textColor = Constants.titleLabelColor
        label.text = Constants.titleText
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = Constants.titleLabelColor
        label.numberOfLines = .zero
        return label
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.verticalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    public override func setupView() {
        addSubview(verticalStackView)
        verticalStackView.equalToSuperView()
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(descriptionLabel)
    }
    
    public override func bind(to viewModel: any StockInfoViewModelProtocol) {
        viewModel.uiModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] uiModel in
                self?.descriptionLabel.text = uiModel?.description
            }
            .store(in: &cancellables)
    }
}
