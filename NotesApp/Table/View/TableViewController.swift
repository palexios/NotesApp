import UIKit

final class TableViewController: UITableViewController {
    // MARK: - Properties
    var viewModel: TableViewModelProtocol
    weak var coordinator: AppCoordinator?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewModel()
        configureTableView()
        configureNavigationBar()
        configureToolBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
    }
    // MARK: - Init's
    init(viewModel: TableViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        self.viewModel.getNumberOfSections()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.getNumberOfNotes(section: section)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as? NoteTableViewCell else { return UITableViewCell() }
        let note = self.viewModel.getNote(indexPath: indexPath)
        // get image
        let image: UIImage!
        if let imageData = self.viewModel.getImage(from: note.urlToImage) {
            image = UIImage(data: imageData)
        } else {
            image = nil
        }
        cell.setupCell(with: note, image: image)
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.getSectionTitle(section: section)
    }
    
    // MARK: - Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showDetail(with: self.viewModel.getNote(indexPath: indexPath))
    }
    
    // MARK: - @objc Methods
    @objc func addNoteBarButtonAction() {
        let viewModel = DetailViewModel(note: nil)
        let detailViewController = DetailViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
// MARK: - Configure tableView
private extension TableViewController {
    func configureTableView() {
        self.tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "NoteTableViewCell")
        self.tableView.rowHeight = 112
        self.tableView.separatorStyle = .none
    }
}
    // MARK: - Configure viewModel
private extension TableViewController {
    func configureViewModel() {
        self.viewModel.reloadTable = {[weak self] in
            self?.tableView.reloadData()
        }
    }
}
    // MARK: - Configure navigationBar
private extension TableViewController {
    func configureNavigationBar() {
        self.title = "Notes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.isNavigationBarHidden = false
    }
}
    // MARK: - Configure toolBar
private extension TableViewController {
    func configureToolBar() {
        self.navigationController?.isToolbarHidden = false
        let addNoteBarButton = UIBarButtonItem(title: "Add Note", style: .done, target: self, action: #selector(addNoteBarButtonAction))
        let flexibleSpace = UIBarButtonItem(systemItem: .flexibleSpace)
        self.toolbarItems = [flexibleSpace, addNoteBarButton]
    }
}
