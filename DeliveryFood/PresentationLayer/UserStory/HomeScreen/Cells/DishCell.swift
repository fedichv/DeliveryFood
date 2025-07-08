//
//  DishCell.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 7/2/25.
//
import UIKit

// MARK: - Model

struct DishCellModel {
    let title: String
    let imageName: UIImage
    let price: String
}

// MARK: - FoodCell

class DishCell: UICollectionViewCell {
    static let reuseIdentifier = "DishCell"
    
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
        label.text = "Dogmie jagong tutung"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let imgLike: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "hand.thumbsdown")
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = .darkGray
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    private let likeCounter: UILabel = {
        let label = UILabel()
        label.text = "999+ |"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let imgDisLike: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "hand.thumbsdown")
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = .darkGray
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    private let disLikeCounter: UILabel = {
        let label = UILabel()
        label.text = "93+ "
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let likeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "hand.thumbsup")
        button.setImage(image, for: .normal)
        button.tintColor = .darkGray
        button.backgroundColor = .brightGray
        button.layer.cornerRadius = 9
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let disLikeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "hand.thumbsdown")
        button.setImage(image, for: .normal)
        button.tintColor = .darkGray
        button.backgroundColor = .brightGray
        button.layer.cornerRadius = 9
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        return button
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
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views and Constraints
    
    private func setupViews() {
        contentView.addSubview(foodImageView)
        contentView.addSubview(restarauntNameLabel)
        contentView.addSubview(likeCounter)
        contentView.addSubview(disLikeCounter)
        contentView.addSubview(priceDish)
        contentView.addSubview(likeButton)
        contentView.addSubview(disLikeButton)
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

            // Лайк кнопка — прибита к правому краю
            likeButton.centerYAnchor.constraint(equalTo: likeCounter.centerYAnchor),
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            likeButton.widthAnchor.constraint(equalToConstant: 18),
            likeButton.heightAnchor.constraint(equalToConstant: 18),

            // Дизлайк кнопка — слева от лайка с небольшим отступом
            disLikeButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            disLikeButton.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -12),
            disLikeButton.widthAnchor.constraint(equalToConstant: 18),
            disLikeButton.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    // MARK: - Configuration
    
    func configure(with model: FoodCellModel) {
        foodImageView.image = model.imageName
        restarauntNameLabel.text = model.title
    }
}
