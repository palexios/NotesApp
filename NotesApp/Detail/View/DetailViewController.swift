import UIKit
import PhotosUI

final class DetailViewController: UIViewController {
    // MARK: - GUI
    private let textView = UITextView()
    private var saveBarButton: UIBarButtonItem!
    private lazy var phpickerViewController: PHPickerViewController = {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let phpickerViewController = PHPickerViewController(configuration: configuration)
        phpickerViewController.delegate = self
        
        return phpickerViewController
        
    }()
    
    // MARK: - Properties
    private let viewModel: DetailViewModelProtocol
    private let coreDataManager = CoreDataManager.shared
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.largeTitleDisplayMode = .never
        configureTextView()
        configureNavigationBar()
        configureToolBar()
        configureGestureRecognizer()
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

// MARK: - UITextViewDelegate
extension DetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.saveBarButton.isHidden = self.viewModel.isEqualText(with: textView.text)
    }
}
// MARK: - PHPickerViewControllerDelegate
extension DetailViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let result = results.first {
            result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        // MARK: - TODO
                    }
                }
            }
        }
        
    }
}
private extension DetailViewController {
    // MARK: - navigationBar
    func configureNavigationBar() {
        saveBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBarButtonAction))
        self.navigationItem.rightBarButtonItem = saveBarButton
        self.saveBarButton.isHidden = true
    }
    @objc func saveBarButtonAction() {
        let text = self.textView.text ?? ""
        let (title, description) = self.viewModel.getTitleAndDescription(from: text)
        self.viewModel.saveNote(title: title, description: description, urlToImage: nil, date: Date())
    }
    
    // MARK: - toolBar
    func configureToolBar() {
        let addPhotoBarButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPhotoBarButtonAction))
        if self.viewModel.isThereNoteModel {
            let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashBarButtonAction))
            self.setToolbarItems([trashButton], animated: true)
        }
    }
    @objc private func addPhotoBarButtonAction() {
        self.showPHPickerViewController()
    }
    @objc private func trashBarButtonAction() {
        self.viewModel.deleteNote()
    }
    
    // MARK: - textView
    func configureTextView() {
        self.textView.delegate = self
        self.textView.font = UIFont.systemFont(ofSize: 28)
        
        configureTextViewLayout()
        
        //set title and description
        
        let (title, description) = self.viewModel.getTitleAndDescription()
        guard let title = title else { return}
        self.textView.text = title
        guard let description = description else { return }
        self.textView.text += "\n\(description)"
    }
    func configureTextViewLayout() {
        self.view.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            textView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            textView.bottomAnchor.constraint(equalTo: self.view.keyboardLayoutGuide.topAnchor, constant: -12)
        ])
    }
    
    // MARK: - gestureRecognizer
    func configureGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(gestureRecognizerAction))
        self.view.addGestureRecognizer(recognizer)
    }
    @objc func gestureRecognizerAction() {
        self.textView.resignFirstResponder()
    }
}
