import UIKit

// MARK: - LoginViewController
final class LoginViewController: UIViewController {
    // MARK: - Properties
    lazy var builder: LoginViewBuilder = {
        let builder = LoginViewBuilder(viewController: self)
        
        return builder
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        builder.setBackgroundGradient()
        builder.setContentStack()
        builder.setTextFieldViews()
        builder.setLogoImageView()
        builder.setButtonsStackView()
        builder.setLoginButton()
        builder.setSignUpButton()
    }
}
