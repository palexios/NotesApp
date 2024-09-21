import UIKit

final class DetailViewController: UIViewController {
    // MARK: - GUI
    private let textView = UITextView()
    
    // MARK: - Properties
    private let viewModel: DetailViewModelProtocol
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.largeTitleDisplayMode = .never
        configureTextView()
    }
    
    // MARK: - Init
    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
private extension DetailViewController {
    // MARK: - textView
    func configureTextView() {
        self.textView.font = UIFont.systemFont(ofSize: 28)
        configureTextViewLayout()
        guard let title = self.viewModel.getTitle() else { return}
        self.textView.text = title
        guard let description = self.viewModel.getDescription() else { return }
        self.textView.text += "\n\(description)"
    }
    func configureTextViewLayout() {
        self.view.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            textView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            textView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
