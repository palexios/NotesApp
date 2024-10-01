import UIKit

protocol Coordinator {
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
final class MainCoordinator: Coordinator {
    var children = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let viewModel = TableViewModel()
        let tableViewController = TableViewController(viewModel: viewModel)
        tableViewController.coordinator = self
        self.navigationController.pushViewController(tableViewController, animated: false)
    }
    
    func detailNote(with viewModel: DetailViewModel) {
        let detailViewController = DetailViewController(viewModel: viewModel)
        detailViewController.coordinator = self
        self.navigationController.pushViewController(detailViewController, animated: true)
    }
}
