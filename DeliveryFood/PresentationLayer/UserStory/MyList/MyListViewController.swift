//
//  MyListView.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 5/1/25.
//

import UIKit

class MyListViewController: UIViewController {
    
    private var likedDishes: [DishCellModel] = []
    
    private let collectionRestaurantCell: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 352, height: 80)
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLikeStatusesFromUserDefaults()
        configure()
        setupViews()
        setupConstraints()
    }
    
    private func loadLikeStatusesFromUserDefaults() {
        likedDishes = (0..<50).compactMap { index in
            let dishID = "dish_\(index)"
            let status = UserDefaultsManager.shared.getLikedStatus(forDishID: dishID)
            if status.isLiked {
                return DishCellModel(
                    id: dishID,
                    title: "Dish Title \(index + 1)",
                    imageName: UIImage(named: "dishImg") ?? UIImage(),
                    price: "$99.99",
                    isLiked: true,
                    isDisliked: status.isDisliked
                )
            } else {
                return nil
            }
        }
    }
    
    private func configure() {
        view.backgroundColor = .white
        let titleLabel = UILabel()
        titleLabel.text = "My List"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        navigationItem.titleView = titleLabel
        
        collectionRestaurantCell.register(MyListCell.self, forCellWithReuseIdentifier: MyListCell.reuseIdentifier)
        collectionRestaurantCell.dataSource = self
        collectionRestaurantCell.delegate = self
    }
    
    private func setupViews() {
        view.addSubview(collectionRestaurantCell)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionRestaurantCell.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            collectionRestaurantCell.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionRestaurantCell.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionRestaurantCell.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - DataSource
extension MyListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likedDishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyListCell.reuseIdentifier, for: indexPath) as? MyListCell else {
            return UICollectionViewCell()
        }
        
        let dish = likedDishes[indexPath.item]
        cell.configure(with: dish)
        cell.setLikeStatus(isLiked: dish.isLiked, isDisliked: dish.isDisliked)
        return cell
    }
}

// MARK: - Delegate
extension MyListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dish = likedDishes[indexPath.item]
        
        let detailVC = DescriptionViewController()
        detailVC.dishID = dish.id
        detailVC.dishName = dish.title
        detailVC.dishImage = dish.imageName
        detailVC.isLiked = dish.isLiked
        detailVC.isDisliked = dish.isDisliked
        detailVC.delegate = self
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - DescriptionViewControllerDelegate
extension MyListViewController: DescriptionViewControllerDelegate {
    func didUpdateLikeStatus(for dishID: String, isLiked: Bool, isDisliked: Bool) {
        loadLikeStatusesFromUserDefaults()
        collectionRestaurantCell.reloadData()
    }
}
