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
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let imgDish: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "dishImg")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let imgLike: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "hand.thumbsup")
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .darkGray
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
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
        let iv = UIImageView()
        iv.image = UIImage(systemName: "hand.thumbsdown")
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .darkGray
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
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
        button.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
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
        button.setImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
        button.tintColor = .darkGray
        button.backgroundColor = .brightGray
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
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
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupViews()
        setupConstraints()

        navigationItem.titleView = {
            let label = UILabel()
            label.text = dishName
            label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            label.textColor = .black
            return label
        }()

        if let image = dishImage { imgDish.image = image }

        let saved = UserDefaultsManager.shared.getLikedStatus(forDishID: dishID)
        isLiked = saved.isLiked
        isDisliked = saved.isDisliked

        if isLiked { updateButtonStyle(selected: likeButton, deselected: disLikeButton) }
        else if isDisliked { updateButtonStyle(selected: disLikeButton, deselected: likeButton) }

        let savedCount = UserDefaultsManager.shared.getOrderCount(forDishID: dishID)
        if savedCount > 0 {
            quantity = savedCount
            quantityLabel.text = "\(quantity)"
            addToOrderButton.setTitle("", for: .normal)
            addedToCartLabel.isHidden = false
            buttonQuantityStack.isHidden = false
        }

        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        disLikeButton.addTarget(self, action: #selector(disLikeButtonTapped), for: .touchUpInside)
        addToOrderButton.addTarget(self, action: #selector(addToOrderTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
    }

    // MARK: - Setup

    private func configure() {
        view.backgroundColor = .white
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

    private func updateButtonStyle(selected: UIButton, deselected: UIButton) {
        UIView.animate(withDuration: 0.2) {
            selected.backgroundColor = .tennéOrTawny
            selected.tintColor = .white
            deselected.backgroundColor = .brightGray
            deselected.tintColor = .darkGray
        }
    }

    private func updateButtonStyleNeutral(_ button: UIButton) {
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
        isLiked ? updateButtonStyle(selected: likeButton, deselected: disLikeButton) : updateButtonStyleNeutral(likeButton)
        UserDefaultsManager.shared.setLikedStatus(isLiked: isLiked, isDisliked: isDisliked, forDishID: dishID)
        CartManager.shared.updateLikeStatus(for: dishID, isLiked: isLiked, isDisliked: isDisliked)
        NotificationCenter.default.post(name: .changeDishLike, object: nil)
        delegate?.didUpdateLikeStatus(for: dishID, isLiked: isLiked, isDisliked: isDisliked)
    }

    @objc private func disLikeButtonTapped() {
        isDisliked.toggle()
        if isDisliked { isLiked = false }
        isDisliked ? updateButtonStyle(selected: disLikeButton, deselected: likeButton) : updateButtonStyleNeutral(disLikeButton)
        UserDefaultsManager.shared.setLikedStatus(isLiked: isLiked, isDisliked: isDisliked, forDishID: dishID)
        CartManager.shared.updateLikeStatus(for: dishID, isLiked: isLiked, isDisliked: isDisliked)
        NotificationCenter.default.post(name: .changeDishLike, object: nil)
        delegate?.didUpdateLikeStatus(for: dishID, isLiked: isLiked, isDisliked: isDisliked)
    }

    @objc private func addToOrderTapped() {
        quantity = 1
        quantityLabel.text = "\(quantity)"
        addToOrderButton.setTitle("", for: .normal)
        addedToCartLabel.isHidden = false
        buttonQuantityStack.isHidden = false
        UserDefaultsManager.shared.setOrderCount(quantity, forDishID: dishID)

        let likes    = Int(likeCounter.text?.replacingOccurrences(of: "+ |", with: "") ?? "0") ?? 0
        let dislikes = Int(disLikeCounter.text?.replacingOccurrences(of: "+", with: "") ?? "0") ?? 0

        let dish = OrderDishModel(
            id: dishID, name: dishName, price: 99.99, quantity: quantity,
            imageData: imgDish.image?.jpegData(compressionQuality: 0.9),
            likes: likes, dislikes: dislikes, isLiked: isLiked, isDisliked: isDisliked
        )
        CartManager.shared.addDish(dish)
    }

    @objc private func increaseQuantity() {
        guard quantity < 99 else { return }
        quantity += 1
        quantityLabel.text = "\(quantity)"
        UserDefaultsManager.shared.setOrderCount(quantity, forDishID: dishID)
        CartManager.shared.updateQuantity(for: dishID, quantity: quantity)
    }

    @objc private func decreaseQuantity() {
        if quantity > 1 {
            quantity -= 1
            quantityLabel.text = "\(quantity)"
            UserDefaultsManager.shared.setOrderCount(quantity, forDishID: dishID)
            CartManager.shared.updateQuantity(for: dishID, quantity: quantity)
        } else if quantity == 1 {
            quantity = 0
            resetAddToOrderButton()
            UserDefaultsManager.shared.setOrderCount(0, forDishID: dishID)
            CartManager.shared.updateQuantity(for: dishID, quantity: 0)
        }
    }
}
