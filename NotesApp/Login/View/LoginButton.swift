import UIKit

final class LoginButton: UIButton {
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        configureLoginButton()
    }
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError()
    }
    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradientBackground(frame: self.bounds)
    }
    // MARK: - Private Methods
    func configureLoginButton() {
        self.setTitle("LOG IN", for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
    }
    func setGradientBackground(frame: CGRect) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [UIColor.loginButtonFirst.cgColor, UIColor.loginButtonLast.cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
        gradientLayer.locations = [0, 1]
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
