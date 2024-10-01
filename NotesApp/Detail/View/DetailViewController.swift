import UIKit
import PhotosUI

final class DetailViewController: UIViewController {
    // MARK: - GUI
    private let photoImageView = UIImageView()
    private let textView = UITextView()
    
    private var saveBarButton: UIBarButtonItem!
    private var addColorBarButton: UIBarButtonItem!
    
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
    weak var coordinator: MainCoordinator?
    
    private var suggestedName: String?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.largeTitleDisplayMode = .never
        configurePhotoImageView()
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
    
    // MARK: - @objc Methods
    @objc func gestureRecognizerAction() {
        self.textView.resignFirstResponder()
    }
    @objc func saveBarButtonAction() {
        let text = self.textView.text ?? ""
        let (title, description) = self.viewModel.getTitleAndDescription(from: text)
        let imageLink = self.viewModel.getUrlToImage()
        let newNote = NoteViewModel(noteModel: NoteModel(title: title, description: description, urlToImage: imageLink, date: Date()))
        let imageData = self.photoImageView.image?.jpegData(compressionQuality: 1)
        self.viewModel.setSuggestedName(suggestedName)
        self.viewModel.saveNote(newNote: newNote, data: imageData, dataName: self.suggestedName)
        self.navigationController?.popViewController(animated: true)
    }
    @objc private func addPhotoBarButtonAction() {
        self.showPHPickerViewController()
    }
    @objc private func trashBarButtonAction() {
        self.viewModel.deleteNote()
        self.navigationController?.popViewController(animated: true)
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
        self.dismiss(animated: true)
        if let result = results.first, let name = result.itemProvider.suggestedName {
            result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        // MARK: - TODO
                        self.photoImageView.image = image
                        self.suggestedName = name
                        self.updatePhotoImageViewLayout()
                        if let oldName = self.viewModel.getSuggestedName() {
                            self.saveBarButton.isHidden = oldName == name
                        }
                    }
                }
            }
        }
        
    }
}

// MARK: - Configure navigationBar
private extension DetailViewController {
    func configureNavigationBar() {
        saveBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBarButtonAction))
        self.navigationItem.rightBarButtonItem = saveBarButton
        self.saveBarButton.isHidden = true
    }
}

// MARK: - Configure toolBar
private extension DetailViewController {
    func configureToolBar() {
        let addPhotoBarButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPhotoBarButtonAction))
        configureAddColorBarButton()
        let flexibleSpace = UIBarButtonItem(systemItem: .flexibleSpace)
        self.setToolbarItems([flexibleSpace, addPhotoBarButton, flexibleSpace], animated: true)
        if self.viewModel.isThereNoteModel {
            let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashBarButtonAction))
            self.setToolbarItems([trashButton, flexibleSpace, addPhotoBarButton,flexibleSpace ,addColorBarButton], animated: true)
        }
    }
}

// MARK: - Configure photoImageView
private extension DetailViewController {
    func configurePhotoImageView() {
        if let url = self.viewModel.getUrlToImage() {
            if let data = self.viewModel.getImageData(from: url) {
                self.photoImageView.image = UIImage(data: data)
            }
        }
        configurePhotoImageViewLayout()
    }
    func configurePhotoImageViewLayout() {
        self.view.addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: photoImageView.image == nil ? 0 : 120)
        ])
    }
    func updatePhotoImageViewLayout() {
        if let heightConstraint = self.photoImageView.constraints.first(where: {$0.firstAttribute == .height}) {
            heightConstraint.constant = photoImageView.image == nil ? 0 : 120
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - Configure phpickerViewController
private extension DetailViewController {
    func showPHPickerViewController() {
        self.present(phpickerViewController, animated: true)
    }
}

// MARK: - Configure textView
private extension DetailViewController {
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
            textView.topAnchor.constraint(equalTo: self.photoImageView.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            textView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            textView.bottomAnchor.constraint(equalTo: self.view.keyboardLayoutGuide.topAnchor, constant: -12)
        ])
    }
}

// MARK: - Configure gestureRecognizer
private extension DetailViewController {
    func configureGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(gestureRecognizerAction))
        self.view.addGestureRecognizer(recognizer)
    }
}

// MARK: - Configure addColorBarButton
private extension DetailViewController {
    func configureAddColorBarButton() {
        let actions = createActions()
        
        let button = UIBarButtonItem(title: "Add Color", style: .plain, target: self, action: nil)
        button.menu = UIMenu(title: "Color", children: actions)
        
        self.addColorBarButton = button
    }
    func createActions() -> [UIAction] {
        let colors = UIColor.additionalColors
        var actions: [UIAction] = []
        for i in colors {
            let colorView = createColorView(with: i)
            let colorImage = createColorImage(from: colorView)
            let action = UIAction(title: i.accessibilityName,image: colorImage) { action in
                print("выбран \(action.title)")
            }
            actions.append(action)
        }
        
        return actions
    }
    func createColorView(with color: UIColor) -> UIView {
        let colorView = UIView(frame: .init(x: 0, y: 0, width: 26, height: 26))
        colorView.layer.cornerRadius = colorView.frame.width / 2
        colorView.backgroundColor = color
        colorView.layer.borderColor = UIColor.darkGray.cgColor
        colorView.layer.borderWidth = 5
        return colorView
        
    }
    func createColorImage(from colorView: UIView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: colorView.bounds.size)
        let image = renderer.image { ctx in
            colorView.layer.render(in: ctx.cgContext)
        }
        return image
    }
    @objc func addColorBarButtonAction() {
        
    }
}
