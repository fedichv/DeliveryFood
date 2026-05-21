import UIKit

struct FoodCellModel {
    let title: String
    let imageName: UIImage
    let address: String
    let deliveryTime: String
}

class RestaurantCell: UICollectionViewCell {
    static let reuseIdentifier = "FoodCell"

    private let foodImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "dishImg")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 25
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let restarauntNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Dapur Ijah Restaurant"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let pinImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "pin")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "13 th Street, 46 W 12th St, NY"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let clockImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "clockImg")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let deliveryTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "3 min - 1.1 km"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let starsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 2.5
        stack.translatesAutoresizingMaskIntoConstraints = false
        for _ in 0..<5 {
            let star = UIImageView()
            star.image = UIImage(named: "star")
            star.contentMode = .scaleAspectFit
            star.widthAnchor.constraint(equalToConstant: 10).isActive = true
            star.heightAnchor.constraint(equalToConstant: 10).isActive = true
            stack.addArrangedSubview(star)
        }
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupViews() {
        contentView.addSubview(foodImageView)
        contentView.addSubview(restarauntNameLabel)
        contentView.addSubview(pinImage)
        contentView.addSubview(addressLabel)
        contentView.addSubview(clockImage)
        contentView.addSubview(deliveryTimeLabel)
        contentView.addSubview(starsStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodImageView.widthAnchor.constraint(equalToConstant: 130),
            foodImageView.heightAnchor.constraint(equalToConstant: 130),

            restarauntNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            restarauntNameLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 20),
            restarauntNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            pinImage.topAnchor.constraint(equalTo: restarauntNameLabel.bottomAnchor, constant: 8),
            pinImage.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 20),
            pinImage.widthAnchor.constraint(equalToConstant: 14),
            pinImage.heightAnchor.constraint(equalToConstant: 14),

            addressLabel.centerYAnchor.constraint(equalTo: pinImage.centerYAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: pinImage.trailingAnchor, constant: 4),
            addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            clockImage.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8),
            clockImage.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 20),
            clockImage.widthAnchor.constraint(equalToConstant: 14),
            clockImage.heightAnchor.constraint(equalToConstant: 14),

            deliveryTimeLabel.centerYAnchor.constraint(equalTo: clockImage.centerYAnchor),
            deliveryTimeLabel.leadingAnchor.constraint(equalTo: clockImage.trailingAnchor, constant: 4),
            deliveryTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            starsStackView.topAnchor.constraint(equalTo: deliveryTimeLabel.bottomAnchor, constant: 8),
            starsStackView.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 20),
            starsStackView.heightAnchor.constraint(equalToConstant: 10),
        ])
    }

    func configure(with model: FoodCellModel) {
        foodImageView.image = model.imageName
        restarauntNameLabel.text = model.title
        addressLabel.text = model.address
        deliveryTimeLabel.text = model.deliveryTime
    }
}
