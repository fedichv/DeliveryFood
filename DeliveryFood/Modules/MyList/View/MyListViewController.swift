import UIKit

class MyListViewController: UIViewController {

    private var likedDishes: [DishCellModel] = []

    private let collectionRestaurantCell: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 352, height: 80)
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(likeDidChange), name: .changeDishLike, object: nil)
        loadLikedDishes()
        configure()
        setupViews()
        setupConstraints()
        collectionRestaurantCell.accessibilityIdentifier = "myListCollection"
    }

    @objc private func likeDidChange() {
        loadLikedDishes()
        collectionRestaurantCell.reloadData()
    }

    private func loadLikedDishes() {
        likedDishes = (0..<50).compactMap { index in
            let id = "dish_\(index)"
            let status = UserDefaultsManager.shared.getLikedStatus(forDishID: id)
            guard status.isLiked else { return nil }
            return DishCellModel(
                id: id,
                title: "Dish Title \(index + 1)",
                imageName: UIImage(named: "dishImg") ?? UIImage(),
                price: "$99.99",
                isLiked: true,
                isDisliked: status.isDisliked
            )
        }
    }

    private func configure() {
        view.backgroundColor = .white
        let label = UILabel()
        label.text = "My List"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        navigationItem.titleView = label
        collectionRestaurantCell.register(MyListCell.self, forCellWithReuseIdentifier: MyListCell.reuseIdentifier)
        collectionRestaurantCell.dataSource = self
        collectionRestaurantCell.delegate = self
    }

    private func setupViews() { view.addSubview(collectionRestaurantCell) }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionRestaurantCell.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            collectionRestaurantCell.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionRestaurantCell.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionRestaurantCell.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension MyListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { likedDishes.count }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyListCell.reuseIdentifier, for: indexPath) as? MyListCell else { return UICollectionViewCell() }
        let dish = likedDishes[indexPath.item]
        cell.configure(with: dish)
        cell.setLikeStatus(isLiked: dish.isLiked, isDisliked: dish.isDisliked)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MyListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dish = likedDishes[indexPath.item]
        let vc = DescriptionViewController()
        vc.dishID = dish.id
        vc.dishName = dish.title
        vc.dishImage = dish.imageName
        vc.isLiked = dish.isLiked
        vc.isDisliked = dish.isDisliked
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - DescriptionViewControllerDelegate

extension MyListViewController: DescriptionViewControllerDelegate {
    func didUpdateLikeStatus(for dishID: String, isLiked: Bool, isDisliked: Bool) {
        loadLikedDishes()
        collectionRestaurantCell.reloadData()
    }
}
//
//  MyListViewController.swift
//  DF
//
//  Created by Владимир Федичев on 5/17/26.
//

