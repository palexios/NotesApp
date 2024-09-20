import UIKit

final class TableViewController: UITableViewController {
    // MARK: - Properties
    let viewModel: TableViewModelProtocol
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
private extension TableViewController {
    func configureTableView() {
        self.tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "NoteTableViewCell")
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
        //TODO: - handle addNote
    }
}
