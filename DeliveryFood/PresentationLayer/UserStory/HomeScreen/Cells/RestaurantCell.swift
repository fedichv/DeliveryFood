//
//  FoodCell.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 5/19/25.
//

import UIKit

// MARK: - Model

struct FoodCellModel {
    let title: String
    let imageName: UIImage
    let address: String
    let deliveryTime: String
}

// MARK: - FoodCell

class RestaurantCell: UICollectionViewCell {
    static let reuseIdentifier = "FoodCell"
    //RestaurantCell
    
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
        label.text = "Dapur Ijah Restaurant"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pin")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        let imageView = UIImageView()
        imageView.image = UIImage(named: "clockImg")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2.5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for _ in 0..<5 {
            let star = UIImageView()
            star.image = UIImage(named: "star")
            star.contentMode = .scaleAspectFit
            star.widthAnchor.constraint(equalToConstant: 10).isActive = true
            star.heightAnchor.constraint(equalToConstant: 10).isActive = true
            stackView.addArrangedSubview(star)
        }
        
        return stackView
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
    
    // MARK: - Configuration
    
    func configure(with model: FoodCellModel) {
        foodImageView.image = model.imageName
        restarauntNameLabel.text = model.title
        addressLabel.text = model.address
        deliveryTimeLabel.text = model.deliveryTime
    }
}
