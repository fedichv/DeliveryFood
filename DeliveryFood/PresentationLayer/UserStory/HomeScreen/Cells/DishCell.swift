//
//  DishCell.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 7/2/25.
//
import UIKit

// MARK: - Model

struct DishCellModel {
    let id: String
    let title: String
    let imageName: UIImage
    let price: String
    var isLiked: Bool = false
    var isDisliked: Bool = false
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
    private let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "hand.thumbsup")
        imageView.tintColor = .darkGray
        imageView.backgroundColor = .brightGray
        imageView.layer.cornerRadius = 9
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let disLikeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "hand.thumbsdown")
        imageView.tintColor = .darkGray
        imageView.backgroundColor = .brightGray
        imageView.layer.cornerRadius = 9
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    // MARK: - Configuration
    
    func configure(with model: DishCellModel) {
        foodImageView.image = model.imageName
        restarauntNameLabel.text = model.title
    }
    
    func setLikeStatus(isLiked: Bool, isDisliked: Bool) {
        if isLiked {
            likeImageView.tintColor = .white
            likeImageView.backgroundColor = .tennéOrTawny
        } else {
            likeImageView.tintColor = .darkGray
            likeImageView.backgroundColor = .brightGray
        }
        
        if isDisliked {
            disLikeImageView.tintColor = .white
            disLikeImageView.backgroundColor = .tennéOrTawny
        } else {
            disLikeImageView.tintColor = .darkGray
            disLikeImageView.backgroundColor = .brightGray
        }
    }
}
