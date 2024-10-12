import UIKit

// MARK: - ViewBuilder
final class ViewBuilder {
    // MARK: - GUI
    private let loginTextField = LoginTextField(placeholder: "Entry your login")
    private let passwordTextField = UITextField()
    
    // MARK: - Properties
    private let viewController: UIViewController
    private let view: UIView
    
    // MARK: - Init
    init(viewController: UIViewController) {
        self.viewController = viewController
        self.view = viewController.view
    }
    
    // MARK: - Methods
    func getGradientLayer(frame: CGRect, colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.locations = [0, 1]
        gradient.colors = colors
        
        return gradient
    }
    func setViewBackground() {
        let gradient = self.getGradientLayer(frame: self.view.frame, colors: [UIColor.white.cgColor, UIColor.additionalBlue.cgColor], startPoint: .init(x: 0, y: 0), endPoint: .init(x: 1, y: 1))
        self.view.layer.addSublayer(gradient)
    }
    func configureLoginTextFieldLayout() {
        self.view.addSubview(loginTextField)
        
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
        ])
    }
}
