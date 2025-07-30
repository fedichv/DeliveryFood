import UIKit

class DishViewController: UIViewController {

    // Массив блюд с уникальным ID
    private var dishes: [DishCellModel] = (0..<50).map { index in
        DishCellModel(
            id: "dish_\(index)" /*UUID().uuidString*/,
            title: "Dish Title \(index + 1)",
            imageName: UIImage(named: "dishImg") ?? UIImage(),
            price: "$99.99",
            isLiked: false,
            isDisliked: false
        )
    }
    
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
    
    // Загружаем лайки/дизлайки из UserDefaults
    private func loadLikeStatusesFromUserDefaults() {
        for index in 0..<dishes.count {
            let dishID = dishes[index].id
            let status = UserDefaultsManager.shared.getLikedStatus(forDishID: dishID)
            dishes[index].isLiked = status.isLiked
            dishes[index].isDisliked = status.isDisliked
        }
    }
    
    private func configure() {
        view.backgroundColor = .white
        let titleLabel = UILabel()
        titleLabel.text = "Dogmie jagong tutung"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        navigationItem.titleView = titleLabel
        
        collectionRestaurantCell.register(DishCell.self, forCellWithReuseIdentifier: DishCell.reuseIdentifier)
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
extension DishViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCell.reuseIdentifier, for: indexPath) as? DishCell else {
            return UICollectionViewCell()
        }
        
        let dish = dishes[indexPath.item]
        let status = UserDefaultsManager.shared.getLikedStatus(forDishID: dish.id)
        dishes[indexPath.item].isLiked = status.isLiked
        dishes[indexPath.item].isDisliked = status.isDisliked
        
        cell.configure(with: dish)
        cell.setLikeStatus(isLiked: dish.isLiked, isDisliked: dish.isDisliked)
        return cell
    }
}

// MARK: - Delegate
extension DishViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dish = dishes[indexPath.item]
        
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
extension DishViewController: DescriptionViewControllerDelegate {
    func didUpdateLikeStatus(for dishID: String, isLiked: Bool, isDisliked: Bool) {
        if let index = dishes.firstIndex(where: { $0.id == dishID }) {
            dishes[index].isLiked = isLiked
            dishes[index].isDisliked = isDisliked
            collectionRestaurantCell.reloadItems(at: [IndexPath(item: index, section: 0)])
        }
    }
}
