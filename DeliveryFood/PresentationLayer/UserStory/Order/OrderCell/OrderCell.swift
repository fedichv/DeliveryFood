//
//  OrderCell.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 7/13/25.
//
import UIKit

class OrderCellDish: UICollectionViewCell {
    static let reuseIdentifier = "OrderCellDish"
    
    // MARK: - UI Elements

    private let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dishImg")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let restarauntNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Название блюда"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let likeCounter: UILabel = {
        let label = UILabel()
        label.text = "0+ |"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let disLikeCounter: UILabel = {
        let label = UILabel()
        label.text = "0+"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceDish: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .green
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "trash")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

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

    // MARK: - Configuration

    func configure(with model: OrderDishModel) {
        foodImageView.image = model.image ?? UIImage(named: "dishImg")
        restarauntNameLabel.text = model.name
        priceDish.text = String(format: "$%.2f", model.price)
        likeCounter.text = "\(model.likes)+ |"
        disLikeCounter.text = "\(model.dislikes)+"
    }

    // MARK: - External button action binding

    func setDeleteAction(target: Any?, action: Selector) {
        deleteButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
