import UIKit

final class TableViewController: UITableViewController {
    // MARK: - Properties
    var viewModel: TableViewModelProtocol
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewModel()
        configureTableView()
        configureNavigationBar()
        configureToolBar()
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
        cell.setupCell(with: note)
        
        return cell
    }
    
    // MARK: - Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = self.viewModel.getNote(indexPath: indexPath)
        let viewModel = DetailViewModel(note: note)
        let detailViewController = DetailViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
private extension TableViewController {
    func configureTableView() {
        self.tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "NoteTableViewCell")
        self.tableView.rowHeight = 112
        self.tableView.separatorStyle = .none
    }
    // MARK: - viewModel
    func configureViewModel() {
        self.viewModel.reloadTable = {[weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func configureNavigationBar() {
        self.title = "Notes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.isNavigationBarHidden = false
    }
    func configureToolBar() {
        self.navigationController?.isToolbarHidden = false
        
        let addNoteBarButton = UIBarButtonItem(title: "Add Note", style: .done, target: self, action: #selector(addNoteBarButtonAction))
        let flexibleSpace = UIBarButtonItem(systemItem: .flexibleSpace)
        self.toolbarItems = [flexibleSpace, addNoteBarButton]
    }
    @objc func addNoteBarButtonAction() {
        let viewModel = DetailViewModel(note: nil)
        let detailViewController = DetailViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
    }
}
