import UIKit

class DishCell: UICollectionViewCell {
    static let reuseIdentifier = "DishCell"

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
        label.text = "Dogmie jagong tutung"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let likeCounter: UILabel = {
        let label = UILabel()
        label.text = "999+ |"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let disLikeCounter: UILabel = {
        let label = UILabel()
        label.text = "93+ "
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let likeImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "hand.thumbsup")
        iv.tintColor = .darkGray
        iv.backgroundColor = .brightGray
        iv.layer.cornerRadius = 9
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let disLikeImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "hand.thumbsdown")
        iv.tintColor = .darkGray
        iv.backgroundColor = .brightGray
        iv.layer.cornerRadius = 9
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let priceDish: UILabel = {
        let label = UILabel()
        label.text = "$99.99"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .green
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        contentView.addSubview(likeImageView)
        contentView.addSubview(disLikeImageView)
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

            likeCounter.topAnchor.constraint(equalTo: restarauntNameLabel.bottomAnchor, constant: 8),
            likeCounter.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 20),

            disLikeCounter.centerYAnchor.constraint(equalTo: likeCounter.centerYAnchor),
            disLikeCounter.leadingAnchor.constraint(equalTo: likeCounter.trailingAnchor, constant: 4),

            priceDish.topAnchor.constraint(equalTo: likeCounter.bottomAnchor, constant: 8),
            priceDish.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 20),

            likeImageView.centerYAnchor.constraint(equalTo: likeCounter.centerYAnchor),
            likeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            likeImageView.widthAnchor.constraint(equalToConstant: 25),
            likeImageView.heightAnchor.constraint(equalToConstant: 25),

            disLikeImageView.centerYAnchor.constraint(equalTo: likeImageView.centerYAnchor),
            disLikeImageView.trailingAnchor.constraint(equalTo: likeImageView.leadingAnchor, constant: -12),
            disLikeImageView.widthAnchor.constraint(equalToConstant: 25),
            disLikeImageView.heightAnchor.constraint(equalToConstant: 25),
        ])
    }

    func configure(with model: DishCellModel) {
        foodImageView.image = model.imageName
        restarauntNameLabel.text = model.title
    }

    func setLikeStatus(isLiked: Bool, isDisliked: Bool) {
        likeImageView.tintColor = isLiked ? .white : .darkGray
        likeImageView.backgroundColor = isLiked ? .tennéOrTawny : .brightGray
        disLikeImageView.tintColor = isDisliked ? .white : .darkGray
        disLikeImageView.backgroundColor = isDisliked ? .tennéOrTawny : .brightGray
    }
}
