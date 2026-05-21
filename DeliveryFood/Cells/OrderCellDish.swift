import UIKit

class OrderCellDish: UICollectionViewCell {
    static let reuseIdentifier = "OrderCellDish"

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
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let likeCounter: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let disLikeCounter: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceDish: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .green
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        contentView.addSubview(likeCounter)
        contentView.addSubview(disLikeCounter)
        contentView.addSubview(priceDish)
        contentView.addSubview(deleteButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodImageView.widthAnchor.constraint(equalToConstant: 80),
            foodImageView.heightAnchor.constraint(equalToConstant: 80),

            restarauntNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            restarauntNameLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 20),
            restarauntNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            likeCounter.topAnchor.constraint(equalTo: restarauntNameLabel.bottomAnchor, constant: 6),
            likeCounter.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 20),

            disLikeCounter.centerYAnchor.constraint(equalTo: likeCounter.centerYAnchor),
            disLikeCounter.leadingAnchor.constraint(equalTo: likeCounter.trailingAnchor, constant: 4),

            priceDish.topAnchor.constraint(equalTo: likeCounter.bottomAnchor, constant: 8),
            priceDish.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 20),

            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            deleteButton.widthAnchor.constraint(equalToConstant: 24),
            deleteButton.heightAnchor.constraint(equalToConstant: 24),
        ])
    }

    func configure(with model: OrderDishModel) {
        foodImageView.image = model.image ?? UIImage(named: "dishImg")
        restarauntNameLabel.text = model.name
        priceDish.text = String(format: "$%.2f", model.price)
        likeCounter.text = "\(model.likes)+ |"
        disLikeCounter.text = "\(model.dislikes)+"
    }

    func setDeleteAction(target: Any?, action: Selector) {
        deleteButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
