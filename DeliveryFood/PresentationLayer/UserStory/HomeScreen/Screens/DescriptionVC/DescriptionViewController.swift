//
//  FoodDetailViewController.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 6/19/25.
//

import UIKit

protocol DescriptionViewControllerDelegate: AnyObject {
    func didUpdateLikeStatus(for dishID: String, isLiked: Bool, isDisliked: Bool)
}

class DescriptionViewController: UIViewController {
    
    
    weak var delegate: DescriptionViewControllerDelegate?
    var dishName: String = ""
    var dishImage: UIImage?
    var dishID: String = ""
    var isLiked: Bool = false
    var isDisliked: Bool = false
    private var quantity: Int = 1
    
    // MARK: - UI Elements
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imgDish: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "dishImg")
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private let imgLike: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "hand.thumbsup")
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
        button.layer.cornerRadius = 15
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
        button.layer.cornerRadius = 15
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
    
    private let descriptionDish: UILabel = {
        let label = UILabel()
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s..."
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addToOrderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to Order", for: .normal)
        button.backgroundColor = .tennéOrTawny
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let addedToCartLabel: UILabel = {
        let label = UILabel()
        label.text = "Added to the order"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonQuantityStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.isHidden = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.tintColor = .white
        return button
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.tintColor = .white
        return button
    }()
    
    private let spacer: UIView = {
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        return spacer
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupViews()
        setupConstraints()

        // Загружаем переданные данные
        navigationItem.titleView = {
            let label = UILabel()
            label.text = dishName
            label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            label.textColor = .black
            return label
        }()
        
        if let image = dishImage {
            imgDish.image = image
        }

        // Сохраняем лайк/дизлайк из UserDefaults
        let savedStatus = UserDefaultsManager.shared.getLikedStatus(forDishID: dishID)
        isLiked = savedStatus.isLiked
        isDisliked = savedStatus.isDisliked

        if isLiked {
            updateButtonStyle(selectedButton: likeButton, deselectedButton: disLikeButton)
        } else if isDisliked {
            updateButtonStyle(selectedButton: disLikeButton, deselectedButton: likeButton)
        }
        
        let savedCount = UserDefaultsManager.shared.getOrderCount(forDishID: dishID)
        if savedCount > 0 {
            quantity = savedCount
            quantityLabel.text = "\(quantity)"
            addToOrderButton.setTitle("", for: .normal)
            addedToCartLabel.isHidden = false
            buttonQuantityStack.isHidden = false
        }
        
        // Привязываем действия к кнопкам
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        disLikeButton.addTarget(self, action: #selector(disLikeButtonTapped), for: .touchUpInside)
        addToOrderButton.addTarget(self, action: #selector(addToOrderTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
    }
    
    // MARK: - UI Setup
    
    private func configure() {
        view.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = "Название блюда"  // Здесь можно динамически вставлять название блюда
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
        navigationItem.titleView = titleLabel
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(imgDish)
        contentView.addSubview(imgLike)
        contentView.addSubview(likeCounter)
        contentView.addSubview(imgDisLike)
        contentView.addSubview(disLikeCounter)
        contentView.addSubview(likeButton)
        contentView.addSubview(disLikeButton)
        contentView.addSubview(priceDish)
        contentView.addSubview(descriptionDish)
        contentView.addSubview(spacer)
        
        view.addSubview(addToOrderButton)
        addToOrderButton.addSubview(addedToCartLabel)
        
        buttonQuantityStack.addArrangedSubview(minusButton)
        buttonQuantityStack.addArrangedSubview(quantityLabel)
        buttonQuantityStack.addArrangedSubview(plusButton)
        addToOrderButton.addSubview(buttonQuantityStack)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imgDish.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            imgDish.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imgDish.widthAnchor.constraint(equalToConstant: 322),
            imgDish.heightAnchor.constraint(equalToConstant: 322),
            
            imgLike.topAnchor.constraint(equalTo: imgDish.bottomAnchor, constant: 19),
            imgLike.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            imgLike.widthAnchor.constraint(equalToConstant: 15),
            imgLike.heightAnchor.constraint(equalToConstant: 15),
            
            likeCounter.centerYAnchor.constraint(equalTo: imgLike.centerYAnchor),
            likeCounter.leadingAnchor.constraint(equalTo: imgLike.trailingAnchor, constant: 6),
            
            imgDisLike.centerYAnchor.constraint(equalTo: imgLike.centerYAnchor),
            imgDisLike.leadingAnchor.constraint(equalTo: likeCounter.trailingAnchor, constant: 6),
            imgDisLike.widthAnchor.constraint(equalToConstant: 15),
            imgDisLike.heightAnchor.constraint(equalToConstant: 15),
            
            disLikeCounter.centerYAnchor.constraint(equalTo: imgDisLike.centerYAnchor),
            disLikeCounter.leadingAnchor.constraint(equalTo: imgDisLike.trailingAnchor, constant: 6),
            
            priceDish.topAnchor.constraint(equalTo: imgLike.bottomAnchor, constant: 14),
            priceDish.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            
            likeButton.topAnchor.constraint(equalTo: imgDish.bottomAnchor, constant: 15),
            likeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalToConstant: 30),
            
            disLikeButton.topAnchor.constraint(equalTo: imgDish.bottomAnchor, constant: 15),
            disLikeButton.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -13),
            disLikeButton.widthAnchor.constraint(equalToConstant: 30),
            disLikeButton.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionDish.topAnchor.constraint(equalTo: priceDish.bottomAnchor, constant: 20),
            descriptionDish.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            descriptionDish.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            addToOrderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addToOrderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addToOrderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            addToOrderButton.heightAnchor.constraint(equalToConstant: 50),
            
            addedToCartLabel.leadingAnchor.constraint(equalTo: addToOrderButton.leadingAnchor, constant: 16),
            addedToCartLabel.centerYAnchor.constraint(equalTo: addToOrderButton.centerYAnchor),
            
            buttonQuantityStack.trailingAnchor.constraint(equalTo: addToOrderButton.trailingAnchor, constant: -16),
            buttonQuantityStack.centerYAnchor.constraint(equalTo: addToOrderButton.centerYAnchor),
            buttonQuantityStack.widthAnchor.constraint(equalToConstant: 90),
            
            spacer.topAnchor.constraint(equalTo: descriptionDish.bottomAnchor),
            spacer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            spacer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            spacer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            spacer.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    // MARK: - UI Updates
    
    private func updateButtonStyle(selectedButton: UIButton, deselectedButton: UIButton) {
        UIView.animate(withDuration: 0.2) {
            selectedButton.backgroundColor = .tennéOrTawny
            selectedButton.tintColor = .white
            
            deselectedButton.backgroundColor = .brightGray
            deselectedButton.tintColor = .darkGray
        }
    }
    
    private func updateButtonStyleNeutral(button: UIButton) {
        UIView.animate(withDuration: 0.2) {
            button.backgroundColor = .brightGray
            button.tintColor = .darkGray
        }
    }
    
    private func resetAddToOrderButton() {
        addToOrderButton.setTitle("Add to Order", for: .normal)
        addedToCartLabel.isHidden = true
        buttonQuantityStack.isHidden = true
        quantity = 0
    }
    
    // MARK: - Actions
    @objc private func likeButtonTapped() {
        isLiked.toggle()
        if isLiked { isDisliked = false }

        if isLiked {
            updateButtonStyle(selectedButton: likeButton, deselectedButton: disLikeButton)
        } else {
            updateButtonStyleNeutral(button: likeButton)
        }

        UserDefaultsManager.shared.setLikedStatus(isLiked: isLiked, isDisliked: isDisliked, forDishID: dishID)
        CartManager.shared.updateLikeStatus(for: dishID, isLiked: isLiked, isDisliked: isDisliked) // <-- по ID
        delegate?.didUpdateLikeStatus(for: dishID, isLiked: isLiked, isDisliked: isDisliked)
    }

    @objc private func disLikeButtonTapped() {
        isDisliked.toggle()
        if isDisliked { isLiked = false }

        if isDisliked {
            updateButtonStyle(selectedButton: disLikeButton, deselectedButton: likeButton)
        } else {
            updateButtonStyleNeutral(button: disLikeButton)
        }

        UserDefaultsManager.shared.setLikedStatus(isLiked: isLiked, isDisliked: isDisliked, forDishID: dishID)
        CartManager.shared.updateLikeStatus(for: dishID, isLiked: isLiked, isDisliked: isDisliked) // <-- по ID
        delegate?.didUpdateLikeStatus(for: dishID, isLiked: isLiked, isDisliked: isDisliked)
    }
    
    @objc private func addToOrderTapped() {
        quantity = 1
        quantityLabel.text = "\(quantity)"
        addToOrderButton.setTitle("", for: .normal)
        addedToCartLabel.isHidden = false
        buttonQuantityStack.isHidden = false

        UserDefaultsManager.shared.setOrderCount(quantity, forDishID: dishID)

        let likesCount = Int(likeCounter.text?.replacingOccurrences(of: "+ |", with: "") ?? "0") ?? 0
        let dislikesCount = Int(disLikeCounter.text?.replacingOccurrences(of: "+", with: "") ?? "0") ?? 0

        let dish = OrderDishModel(
            id: dishID,
            name: dishName,
            price: 99.99,
            quantity: quantity,
            imageData: imgDish.image?.jpegData(compressionQuality: 0.9),
            likes: likesCount,
            dislikes: dislikesCount,
            isLiked: isLiked,
            isDisliked: isDisliked
        )

        CartManager.shared.addDish(dish)
    }
    
    @objc private func increaseQuantity() {
        if quantity < 99 {
            quantity += 1
            quantityLabel.text = "\(quantity)"
            UserDefaultsManager.shared.setOrderCount(quantity, forDishID: dishID)
            CartManager.shared.updateQuantity(for: dishID, quantity: quantity)  // <-- по ID
        }
    }

    @objc private func decreaseQuantity() {
        if quantity > 1 {
            quantity -= 1
            quantityLabel.text = "\(quantity)"
            UserDefaultsManager.shared.setOrderCount(quantity, forDishID: dishID)
            CartManager.shared.updateQuantity(for: dishID, quantity: quantity)  // <-- по ID
        } else if quantity == 1 {
            quantity = 0
            quantityLabel.text = "0"
            resetAddToOrderButton()
            UserDefaultsManager.shared.setOrderCount(quantity, forDishID: dishID)
            CartManager.shared.updateQuantity(for: dishID, quantity: quantity)  // <-- по ID
        }
    }
}
