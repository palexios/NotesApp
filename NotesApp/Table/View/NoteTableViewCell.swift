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
    }

private extension NoteTableViewCell {
    // MARK: - configure containerView
    func configureContainerView() {
        containerView.backgroundColor = UIColor.lightYellow
        containerView.layer.cornerRadius = 10
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
    // MARK: - configure photoImageView
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
    
    // MARK: - configure titleLabel
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
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: self.containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: self.titleLabel.font.lineHeight)
        ])
    }
    // MARK: - configure descriptionLabel
    func configureDescriptionLabel() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        configureDescriptionLabelLayout()
    }
    func configureDescriptionLabelLayout() {
        if self.photoImageView.image == nil {
            self.containerView.addSubview(descriptionLabel)
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
                descriptionLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
                descriptionLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
                descriptionLabel.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 1, constant: -self.titleLabel.font.lineHeight),
                descriptionLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor)
            ])
        } else {
            descriptionLabel.removeFromSuperview()
        }
        
    }
}
