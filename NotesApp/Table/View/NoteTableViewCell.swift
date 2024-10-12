import UIKit

final class NoteTableViewCell: UITableViewCell {
    // MARK: - GUI
    let stackView = UIStackView()
    let secondStackView = UIStackView()
    let photoImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    // MARK: - Init's
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .darkGray
        configureStackView()
        configureTitleLabel()
        configureDescriptionLabel()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Methods
    func setupCell(with cell: NoteViewModel, image: UIImage?) {
        self.photoImageView.image = image
        self.titleLabel.text = cell.title
        self.descriptionLabel.text = cell.description
    }
}
// MARK: - Configure stackView
private extension NoteTableViewCell {
    func configureStackView() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        configureStackViewLayout()
    }
    func configureStackViewLayout() {
        self.contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
// MARK: - Configure titleLabel
private extension NoteTableViewCell {
    func configureTitleLabel() {
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleLabel.contentMode = .topLeft
        
        configureTitleLabelLayout()
    }
    func configureTitleLabelLayout() {
        self.stackView.addArrangedSubview(titleLabel)
    }
}
// MARK: - Configure descriptionLabel
private extension NoteTableViewCell {
    func configureDescriptionLabel() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        configureDescriptionLabelLayout()
    }
    func configureDescriptionLabelLayout() {
        self.stackView.addArrangedSubview(descriptionLabel)
    }
}
