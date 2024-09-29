    import UIKit

final class NoteTableViewCell: UITableViewCell {
    // MARK: - GUI
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let photoImageView = UIImageView()
    private let descriptionLabel = UILabel()
    
    // MARK: - Init's
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    // MARK: - Methods
    func setupCell(with cell: NoteViewModel, image: UIImage?) {
        self.photoImageView.image = image
        self.titleLabel.text = cell.title
        self.descriptionLabel.text = cell.description
        
        configureContainerView()
        configurePhotoImageView()
        configureTitleLabel()
        configureDescriptionLabel()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = contentView.frame.inset(by: .init(top: 5, left: 5, bottom: 5, right: 5))
    }
}

// MARK: - Configure containerView
private extension NoteTableViewCell {
    func configureContainerView() {
        containerView.backgroundColor = UIColor.lightYellow
        containerView.layer.cornerRadius = 20
        configureContainerViewLayout()
    }
    func configureContainerViewLayout() {
        self.contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
// MARK: - Configure photoImageView
private extension NoteTableViewCell {
    func configurePhotoImageView() {
        self.photoImageView.clipsToBounds = true
        self.photoImageView.layer.cornerRadius = self.containerView.layer.cornerRadius
        configurePhotoImageViewLayout()
    }
    func configurePhotoImageViewLayout() {
        if let _ = self.photoImageView.image {
            self.containerView.addSubview(photoImageView)
            photoImageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                photoImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor),
                photoImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
                photoImageView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
                photoImageView.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor),
                photoImageView.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, constant: -self.titleLabel.font.lineHeight - 8)
            ])
        } else {
            self.photoImageView.removeFromSuperview()
        }
    }
}

// MARK: - Configure titleLabel
private extension NoteTableViewCell {
    func configureTitleLabel() {
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 1
        self.containerView.addSubview(titleLabel)
        configureTitleLabelLayout()
    }
    func configureTitleLabelLayout() {
        self.containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: self.containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: self.titleLabel.font.lineHeight)
        ])
    }
}

// MARK: - Configure descriptionLabel
private extension NoteTableViewCell {
    func configureDescriptionLabel() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .darkGray
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        configureDescriptionLabelLayout()
    }
    func configureDescriptionLabelLayout() {
        if self.photoImageView.image == nil {
            self.containerView.addSubview(descriptionLabel)
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4),
                descriptionLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 16),
                descriptionLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
                descriptionLabel.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 1, constant: -self.titleLabel.font.lineHeight - 28),
                descriptionLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -8)
            ])
        } else {
            descriptionLabel.removeFromSuperview()
        }
    }
}
