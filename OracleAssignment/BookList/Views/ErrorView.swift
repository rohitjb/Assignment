import UIKit

class ErrorView: UIView {
    private let errorMessageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateViewWithError(error: ErrorViewState) {
        errorMessageLabel.text = error.errorMessage
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.textAlignment = .center
    }
    
    private func setup() {
        addSubview(errorMessageLabel)
        applyConstraints()
    }
    
    private func applyConstraints() {
        errorMessageLabel.pinLeading(to: self, constant: 8)
        errorMessageLabel.pinTrailing(to: self, constant: 8)
        errorMessageLabel.pinCenterY(to: self)
    }

}
