//
//  FoodDetailViewController.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 6/19/25.
//
import UIKit

protocol DescriptionViewControllerDelegate: AnyObject {
    func didAddDishToOrder(_ dish: DishOrderModel)
}

class DescriptionViewController: UIViewController {
    
    weak var delegate: DescriptionViewControllerDelegate?
    
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
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries"
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
        label.adjustsFontSizeToFitWidth = true       // масштабируем текст
        label.minimumScaleFactor = 0.5               // минимальный масштаб
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
    
    private var quantity: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupViews()
        setupConstraints()
        
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        disLikeButton.addTarget(self, action: #selector(disLikeButtonTapped), for: .touchUpInside)
        addToOrderButton.addTarget(self, action: #selector(addToOrderTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
    }
    
    private func configure() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = "Название блюда"
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
        contentView.addSubview(addToOrderButton)
        addToOrderButton.addSubview(addedToCartLabel)
        
        buttonQuantityStack.addArrangedSubview(minusButton)
        buttonQuantityStack.addArrangedSubview(quantityLabel)
        buttonQuantityStack.addArrangedSubview(plusButton)
        addToOrderButton.addSubview(buttonQuantityStack)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
            
            // Лайк
            imgLike.topAnchor.constraint(equalTo: imgDish.bottomAnchor, constant: 19),
            imgLike.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            imgLike.widthAnchor.constraint(equalToConstant: 15),
            imgLike.heightAnchor.constraint(equalToConstant: 15),
            
            likeCounter.centerYAnchor.constraint(equalTo: imgLike.centerYAnchor),
            likeCounter.leadingAnchor.constraint(equalTo: imgLike.trailingAnchor, constant: 6),
            
            // Дизлайк
            imgDisLike.centerYAnchor.constraint(equalTo: imgLike.centerYAnchor),
            imgDisLike.leadingAnchor.constraint(equalTo: likeCounter.trailingAnchor, constant: 6),
            imgDisLike.widthAnchor.constraint(equalToConstant: 15),
            imgDisLike.heightAnchor.constraint(equalToConstant: 15),
            
            disLikeCounter.centerYAnchor.constraint(equalTo: imgDisLike.centerYAnchor),
            disLikeCounter.leadingAnchor.constraint(equalTo: imgDisLike.trailingAnchor, constant: 6),
            
            // Цена
            priceDish.topAnchor.constraint(equalTo: imgLike.bottomAnchor, constant: 14),
            priceDish.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            
            // Кнопки лайков справа
            likeButton.topAnchor.constraint(equalTo: imgDish.bottomAnchor, constant: 15),
            likeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalToConstant: 30),
            
            disLikeButton.topAnchor.constraint(equalTo: imgDish.bottomAnchor, constant: 15),
            disLikeButton.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -13),
            disLikeButton.widthAnchor.constraint(equalToConstant: 30),
            disLikeButton.heightAnchor.constraint(equalToConstant: 30),
            
            // Описание
            descriptionDish.topAnchor.constraint(equalTo: priceDish.bottomAnchor, constant: 20),
            descriptionDish.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            descriptionDish.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            // Кнопка "Add to Order"
            addToOrderButton.topAnchor.constraint(equalTo: descriptionDish.bottomAnchor, constant: 19),
            addToOrderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addToOrderButton.widthAnchor.constraint(equalToConstant: 354),
            addToOrderButton.heightAnchor.constraint(equalToConstant: 50),
            addToOrderButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            addedToCartLabel.leadingAnchor.constraint(equalTo: addToOrderButton.leadingAnchor, constant: 16),
            addedToCartLabel.centerYAnchor.constraint(equalTo: addToOrderButton.centerYAnchor),
            
            buttonQuantityStack.trailingAnchor.constraint(equalTo: addToOrderButton.trailingAnchor, constant: -16),
            buttonQuantityStack.centerYAnchor.constraint(equalTo: addToOrderButton.centerYAnchor),
            buttonQuantityStack.widthAnchor.constraint(equalToConstant: 90),
            
        ])
    }
    
    private func updateButtonStyle(selectedButton: UIButton, deselectedButton: UIButton) {
        UIView.animate(withDuration: 0.2) {
            selectedButton.backgroundColor = .tennéOrTawny
            selectedButton.tintColor = .white
            
            deselectedButton.backgroundColor = .brightGray
            deselectedButton.tintColor = .darkGray
        }
    }
    
    @objc private func likeButtonTapped() {
        updateButtonStyle(selectedButton: likeButton, deselectedButton: disLikeButton)
    }
    
    @objc private func disLikeButtonTapped() {
        updateButtonStyle(selectedButton: disLikeButton, deselectedButton: likeButton)
    }
    
    @objc private func addToOrderTapped() {
        addToOrderButton.setTitle("", for: .normal)
        addedToCartLabel.isHidden = false
        buttonQuantityStack.isHidden = false
        quantity = 1
        quantityLabel.text = "\(quantity)"

        // Пример добавляемой информации
        let dish = DishOrderModel(
            name: "Название блюда",  // можешь заменить на реальное имя, если оно есть
            price: 99.99,            // заменить на актуальную цену
            quantity: quantity
        )
        
        delegate?.didAddDishToOrder(dish)
    }
    
    @objc private func increaseQuantity() {
        if quantity < 99 {
            quantity += 1
            quantityLabel.text = "\(quantity)"
        }
    }
    
    @objc private func decreaseQuantity() {
        if quantity > 1 {
            quantity -= 1
            quantityLabel.text = "\(quantity)"
        } else if quantity == 1 {
            // Если количество дошло до 1 и нажали "-", сбрасываем в исходное состояние (удаляем из корзины)
            quantity = 0
            quantityLabel.text = "0"
            resetAddToOrderButton()
        }
    }
    
    private func resetAddToOrderButton() {
        addToOrderButton.setTitle("Add to Order", for: .normal) // Показываем исходный текст кнопки
        addedToCartLabel.isHidden = true                        // Скрываем "Добавлено в заказ"
        buttonQuantityStack.isHidden = true                     // Скрываем счетчик с кнопками
        quantity = 0
    }
}
