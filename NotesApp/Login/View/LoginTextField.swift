import UIKit

// MARK: - LoginTextField
final class LoginTextField: UITextField {
    // MARK: - Init
    init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        
        configureLoginTextField()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Override Methods
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    // MARK: - Private Methods
    private func configureLoginTextField() {
        self.textColor = .white
        self.font = UIFont.systemFont(ofSize: 16, weight: .light)
        
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [
            .font: UIFont.systemFont(ofSize: 16, weight: .light),
            .foregroundColor: UIColor.systemGray4
            ])
    }
}
