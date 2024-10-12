import UIKit

enum TextFieldType {
    case username
    case password
}

// MARK: - ViewBuilder
final class ViewBuilder {
    // MARK: - GUI
    lazy var logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage.notepad
        logo.contentMode = .scaleAspectFit
        
        return logo
    }()
    lazy var usernameTextField: LoginTextField = {
        let textField = LoginTextField(placeholder: "Username")
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        return textField
    }()
    lazy var passwordTextField: LoginTextField = {
        let textField = LoginTextField(placeholder: "Password")
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
        return textField
    }()
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 40
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    // MARK: - Properties
    private let view: UIView
    
    // MARK: - Init
    init(view: UIView) {
        self.view = view
    }
    
    // MARK: - Methods
    func setBackgroundGradient() {
        let gradientLayer = getBackroundGradient()
        self.view.layer.addSublayer(gradientLayer)
    }
    func setContentStack() {
        self.view.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            contentStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            contentStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)
        ])
    }
    func setTextFieldViews() {
        let usernameFieldView = self.getTextFieldView(type: .username, textField: usernameTextField)
        self.contentStack.addArrangedSubview(usernameFieldView)
        
        let passwordFieldView = self.getTextFieldView(type: .password, textField: passwordTextField)
        self.contentStack.addArrangedSubview(passwordFieldView)
    }
    func setLoginButton() {
        let loginButton = LoginButton()
        self.contentStack.addArrangedSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    func setLogoImageView() {
        self.view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.bottomAnchor.constraint(equalTo: contentStack.topAnchor, constant: -50),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    // MARK: - Private Methods
    private func getBackroundGradient() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.additionalBlue.cgColor, UIColor.additionalDarkBlue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [0, 1]
        
        return gradientLayer
    }
    
    private func getTextFieldView(type: TextFieldType, textField: LoginTextField) -> UIView {
        lazy var imageAndTextFieldView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        lazy var iconImageView: UIImageView = {
            let image = UIImageView()
            switch type {
            case .username:
                image.image = UIImage(systemName: "envelope")
            case .password:
                image.image = UIImage(systemName: "lock")
            }
            image.contentMode = .scaleAspectFit
            image.tintColor = .systemGray4
            
            imageAndTextFieldView.addSubview(image)
            image.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                image.widthAnchor.constraint(equalToConstant: 20),
                image.leadingAnchor.constraint(equalTo: imageAndTextFieldView.leadingAnchor),
                image.topAnchor.constraint(equalTo: imageAndTextFieldView.topAnchor),
                image.bottomAnchor.constraint(equalTo: imageAndTextFieldView.bottomAnchor)
            ])
            
            return image
        }()
        
        imageAndTextFieldView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor),
            textField.trailingAnchor.constraint(equalTo: imageAndTextFieldView.trailingAnchor),
            textField.topAnchor.constraint(equalTo: imageAndTextFieldView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: imageAndTextFieldView.bottomAnchor)
        ])
        
        lazy var containerView: UIView = {
            let containerView = UIView()
            
            return containerView
        }()
        
        lazy var lineView: UIView = {
            let lineView = UIView()
            lineView.backgroundColor = .white
            
            lineView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                lineView.heightAnchor.constraint(equalToConstant: 1)
            ])
            
            return lineView
        }()
        containerView.addSubview(imageAndTextFieldView)
        NSLayoutConstraint.activate([
            imageAndTextFieldView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageAndTextFieldView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageAndTextFieldView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        containerView.addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            lineView.topAnchor.constraint(equalTo: imageAndTextFieldView.bottomAnchor),
            lineView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }
}
