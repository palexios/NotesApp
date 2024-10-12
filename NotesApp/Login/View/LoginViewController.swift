import UIKit

// MARK: - LoginViewController
final class LoginViewController: UIViewController {
    // MARK: - Properties
    lazy var builder: ViewBuilder = {
        let builder = ViewBuilder(view: self.view)
        
        return builder
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        builder.setBackgroundGradient()
        builder.setContentStack()
        builder.setTextFieldViews()
        builder.setLoginButton()
        builder.setLogoImageView()
    }
}
