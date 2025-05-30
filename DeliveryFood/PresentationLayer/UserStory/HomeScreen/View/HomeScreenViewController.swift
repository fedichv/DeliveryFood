//
//  HomeScreenView.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 5/1/25.
//

import UIKit

// MARK: - Protocols

protocol HomeScreenViewOutput: AnyObject {
    func didChangeSearchText(_ text: String)
}

protocol HomeScreenViewInput: AnyObject {
    func didTextChange(_ text: String)
}

enum CellColorType {
    case blue
    case pink

    var color: UIColor {
        switch self {
        case .blue:
            return .lightBlue
        case .pink:
            return .lightPink
        }
    }
}

// MARK: - Models

struct FoodItemModel {
    let title: String
    let imageName: String
}

struct FoodConstants {
    static let foodItems: [FoodItemModel] = [
        FoodItemModel(title: "Drink", imageName: "drink"),
        FoodItemModel(title: "Food", imageName: "food"),
        FoodItemModel(title: "Cake", imageName: "cake"),
        FoodItemModel(title: "Snack", imageName: "snack")
    ]

    static let foodMenuItems: [FoodItemModel] = [
        FoodItemModel(title: "Burgers", imageName: "burgerImg"),
        FoodItemModel(title: "Fruit", imageName: "fruitImg"),
        FoodItemModel(title: "Pizza", imageName: "pizzaImg"),
        FoodItemModel(title: "Sushi", imageName: "sushiImg"),
        FoodItemModel(title: "BBQ", imageName: "bbqImg"),
        FoodItemModel(title: "Noodle", imageName: "soupImg")
    ]
}

// MARK: - HomeScreenViewController

class HomeScreenViewController: UIViewController {

    // MARK: - Properties

    weak var viewModel: HomeScreenViewOutput?
    private var collectionFoodCellHeightConstraint: NSLayoutConstraint?

    // MARK: - Initializer

    init(viewModel: HomeScreenViewOutput? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Elements

    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = true
        return scroll
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let collectionMenuSectionCell: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 70, height: 91)
        layout.minimumLineSpacing = 40

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    private let collectionFoodMenuCell: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 130, height: 130)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.sectionInset = .zero

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    private let collectionFoodCell: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 318, height: 130)
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()

    private let searchField: UITextField = {
        let textField = PaddedTextField()
        textField.placeholder = "Search"
        textField.textColor = .darkGray
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .brightGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let pinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pin")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "9 West 46 Th Street, New York City"
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let foodMenuLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Food Menu"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let nearMeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Near Me"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let foodMenuViewAllLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "View All"
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let nearMeViewAllLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "View All"
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupViews()
        setupConstraints()
        hideKeyboardWhenTappedAround()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionFoodCell.layoutIfNeeded()
        let height = collectionFoodCell.collectionViewLayout.collectionViewContentSize.height
        collectionFoodCellHeightConstraint?.constant = height
    }

    // MARK: - Setup

    private func configure() {
        view.backgroundColor = .white
        searchField.delegate = self

        collectionMenuSectionCell.register(MenuSectionCell.self, forCellWithReuseIdentifier: MenuSectionCell.reuseIdentifier)
        collectionMenuSectionCell.dataSource = self
        collectionMenuSectionCell.delegate = self

        collectionFoodMenuCell.register(FoodMenuCell.self, forCellWithReuseIdentifier: FoodMenuCell.reuseIdentifier)
        collectionFoodMenuCell.dataSource = self
        collectionFoodMenuCell.delegate = self

        collectionFoodCell.register(FoodCell.self, forCellWithReuseIdentifier: FoodCell.reuseIdentifier)
        collectionFoodCell.dataSource = self
        collectionFoodCell.delegate = self
    }

    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(searchField)
        contentView.addSubview(pinImage)
        contentView.addSubview(addressLabel)
        contentView.addSubview(collectionMenuSectionCell)
        contentView.addSubview(foodMenuLabel)
        contentView.addSubview(foodMenuViewAllLabel)
        contentView.addSubview(collectionFoodMenuCell)
        contentView.addSubview(nearMeLabel)
        contentView.addSubview(nearMeViewAllLabel)
        contentView.addSubview(collectionFoodCell)
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

            searchField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            searchField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            searchField.widthAnchor.constraint(equalToConstant: 354),
            searchField.heightAnchor.constraint(equalToConstant: 50),

            pinImage.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 16),
            pinImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            pinImage.widthAnchor.constraint(equalToConstant: 20),
            pinImage.heightAnchor.constraint(equalToConstant: 20),

            addressLabel.centerYAnchor.constraint(equalTo: pinImage.centerYAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: pinImage.trailingAnchor, constant: 10),

            collectionMenuSectionCell.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 30),
            collectionMenuSectionCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            collectionMenuSectionCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionMenuSectionCell.heightAnchor.constraint(equalToConstant: 91),

            foodMenuLabel.topAnchor.constraint(equalTo: collectionMenuSectionCell.bottomAnchor, constant: 30),
            foodMenuLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),

            foodMenuViewAllLabel.centerYAnchor.constraint(equalTo: foodMenuLabel.centerYAnchor),
            foodMenuViewAllLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),

            collectionFoodMenuCell.topAnchor.constraint(equalTo: foodMenuLabel.bottomAnchor, constant: 26),
            collectionFoodMenuCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            collectionFoodMenuCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionFoodMenuCell.heightAnchor.constraint(equalToConstant: 280),

            nearMeLabel.topAnchor.constraint(equalTo: collectionFoodMenuCell.bottomAnchor, constant: 20),
            nearMeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),

            nearMeViewAllLabel.centerYAnchor.constraint(equalTo: nearMeLabel.centerYAnchor),
            nearMeViewAllLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),

            collectionFoodCell.topAnchor.constraint(equalTo: nearMeLabel.bottomAnchor, constant: 26),
            collectionFoodCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionFoodCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            collectionFoodCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        collectionFoodCellHeightConstraint = collectionFoodCell.heightAnchor.constraint(equalToConstant: 430)
        collectionFoodCellHeightConstraint?.isActive = true
    }
}

// MARK: - UICollectionViewDataSource

extension HomeScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionMenuSectionCell {
            return FoodConstants.foodItems.count
        } else if collectionView == self.collectionFoodMenuCell {
            return FoodConstants.foodMenuItems.count
        } else if collectionView == self.collectionFoodCell {
            return 50
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionMenuSectionCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuSectionCell.reuseIdentifier, for: indexPath) as? MenuSectionCell else {
                return UICollectionViewCell()
            }

            let item = FoodConstants.foodItems[indexPath.item]
            cell.configure(with: MenuSectionCellModel(
                title: item.title,
                image: item.imageName.image ?? .init()
            ))

            return cell

        } else if collectionView == self.collectionFoodMenuCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodMenuCell.reuseIdentifier, for: indexPath) as? FoodMenuCell else {
                return UICollectionViewCell()
            }

            let item = FoodConstants.foodMenuItems[indexPath.item]
            cell.configure(with: FoodMenuCellModel(
                title: item.title,
                image: item.imageName.image ?? .init()
            ))

            let backgroundColorsCell: [CellColorType] = [
                .blue, .pink, .pink,
                .blue, .blue, .pink
            ]

            if indexPath.item < backgroundColorsCell.count {
                cell.contentView.backgroundColor = backgroundColorsCell[indexPath.item].color
            } else {
                cell.contentView.backgroundColor = .brightGray
            }

            return cell

        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCell.reuseIdentifier, for: indexPath) as? FoodCell else {
                return UICollectionViewCell()
            }
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate

extension HomeScreenViewController: UICollectionViewDelegate {
    // Additional delegate methods can go here
}

// MARK: - HomeScreenViewInput

extension HomeScreenViewController: HomeScreenViewInput {
    func didTextChange(_ text: String) {
        searchField.text = text
    }
}

// MARK: - UITextFieldDelegate

extension HomeScreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel?.didChangeSearchText(textField.text ?? "")
    }
}
