import UIKit

final class AppCoordinator: Coordinator {
    // MARK: - Properties
    var navigationController: UINavigationController
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        showMain()
    }
    
    func showMain() {
        let tableViewModel = TableViewModel()
        let tableViewController = TableViewController(viewModel: tableViewModel)
        tableViewController.coordinator = self
        self.navigationController.pushViewController(tableViewController, animated: true)
    }
    
    func showDetail(with noteViewModel: NoteViewModel) {
        let detailViewModel = DetailViewModel(note: noteViewModel)
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        self.navigationController.pushViewController(detailViewController, animated: true)
    }
}
