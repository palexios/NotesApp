import UIKit

final class NoteTableViewCell: UITableViewCell {
    // MARK: - GUI
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    // MARK: - Init's
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureContainerView()
        configureTitleLabel()
        configureDescriptionLabel()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    // MARK: - Methods
    func setupCell(with cell: NoteViewModel) {
        self.titleLabel.text = cell.title
        self.descriptionLabel.text = cell.description
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
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4)
        ])
    }
    
    // MARK: - configure titleLabel
    func configureTitleLabel() {
        titleLabel.textAlignment = .left
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 1
        
        configureTitleLabelLayout()
    }
    func configureTitleLabelLayout() {
        self.containerView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -4),
            titleLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    // MARK: - configure descriptionLabel
    func configureDescriptionLabel() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textColor = UIColor.black
        
        configureDescriptionLabelLayout()
    }
    func configureDescriptionLabelLayout() {
        self.containerView.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -4),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.containerView.bottomAnchor)
        ])
    }
}

