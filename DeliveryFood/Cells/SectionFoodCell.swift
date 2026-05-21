import UIKit

struct FoodMenuCellModel {
    var title: String
    var image: UIImage
}

class SectionFoodCell: UICollectionViewCell {
    static let reuseIdentifier = "FoodMenuCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupViews() {
        contentView.backgroundColor = .brightGray
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -12),

            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 110),
            imageView.heightAnchor.constraint(equalToConstant: 110),
        ])
    }

    func configure(with model: FoodMenuCellModel) {
        titleLabel.text = model.title
        imageView.image = model.image
    }
}
