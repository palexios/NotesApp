import UIKit

// MARK: - TextFieldType
enum TextFieldType {
    case username
    case password
}

// MARK: - ViewBuilder
final class LoginViewBuilder {
    // MARK: - GUI
    lazy var usernameTextField: LoginTextField = {
        let textField = LoginTextField(placeholder: "Email")
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        
        textField.delegate = self.viewController
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        return textField
    }()
    
    lazy var passwordTextField: LoginTextField = {
        let textField = LoginTextField(placeholder: "Password")
        textField.isSecureTextEntry = true
        
        textField.delegate = self.viewController
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        return textField
    }()
    
    lazy var loginButton: LoginButton = {
        let button = LoginButton()
        
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Don't have an account?", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        button.setTitleColor(.systemGray4, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Private GUI
    private lazy var logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage.notepad
        logo.contentMode = .scaleAspectFit
        
        return logo
    }()
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 5
        
        return stack
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
    private let viewController: LoginViewController
    
    // MARK: - Init
    init(viewController: LoginViewController) {
        self.view = viewController.view
        self.viewController = viewController
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
        self.buttonsStackView.addArrangedSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    func setSignUpButton() {
        lazy var containerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
        containerView.addSubview(signUpButton)
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
        self.buttonsStackView.addArrangedSubview(containerView)
    }
    func setLogoImageView() {
        self.view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.bottomAnchor.constraint(equalTo: contentStack.topAnchor, constant: -self.view.frame.height / 8),
            logoImageView.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.275),
            logoImageView.heightAnchor.constraint(equalToConstant: self.view.frame.width * 0.275),
            logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    func setButtonsStackView() {
        self.view.addSubview(buttonsStackView)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            buttonsStackView.topAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: self.view.frame.height / 10),
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
