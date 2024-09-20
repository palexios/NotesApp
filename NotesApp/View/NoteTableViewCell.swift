import UIKit

final class NoteTableViewCell: UITableViewCell {
    // MARK: - GUI
    private let containerView = UIView()
    private let titleLabel = UILabel()
    
    // MARK: - Init's
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureContainerView()
        configureTitleLabel()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    // MARK: - Methods
    func setupCell(with cell: NoteViewModel) {
        self.titleLabel.text = cell.title
    }
}

private extension NoteTableViewCell {
    // MARK: - configure containerView
    func configureContainerView() {
        containerView.backgroundColor = UIColor.systemYellow
        containerView.layer.cornerRadius = 10
        
        configureContainerViewLayout()
    }
    func configureContainerViewLayout() {
        self.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    }
    
    // MARK: - configure titleLabel
    func configureTitleLabel() {
        titleLabel.font = .boldSystemFont(ofSize: 18)
        
        configureTitleLabelLayout()
    }
    func configureTitleLabelLayout() {
        self.containerView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -10)
        ])
    }
}

