import UIKit

class DishViewController: UIViewController {

    private var dishes: [DishCellModel] = (0..<50).map { index in
        DishCellModel(
            id: "dish_\(index)",
            title: "Dish Title \(index + 1)",
            imageName: UIImage(named: "dishImg") ?? UIImage(),
            price: "$99.99"
        )
    }

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
        loadLikeStatuses()
        configure()
        setupViews()
        setupConstraints()
    }

    private func loadLikeStatuses() {
        for i in 0..<dishes.count {
            let status = UserDefaultsManager.shared.getLikedStatus(forDishID: dishes[i].id)
            dishes[i].isLiked = status.isLiked
            dishes[i].isDisliked = status.isDisliked
        }
    }

    private func configure() {
        view.backgroundColor = .white
        let label = UILabel()
        label.text = "Dogmie jagong tutung"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        navigationItem.titleView = label

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

// MARK: - UICollectionViewDataSource

extension DishViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { dishes.count }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCell.reuseIdentifier, for: indexPath) as? DishCell else { return UICollectionViewCell() }
        let dish = dishes[indexPath.item]
        let status = UserDefaultsManager.shared.getLikedStatus(forDishID: dish.id)
        dishes[indexPath.item].isLiked = status.isLiked
        dishes[indexPath.item].isDisliked = status.isDisliked
        cell.configure(with: dish)
        cell.setLikeStatus(isLiked: dish.isLiked, isDisliked: dish.isDisliked)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension DishViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dish = dishes[indexPath.item]
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

extension DishViewController: DescriptionViewControllerDelegate {
    func didUpdateLikeStatus(for dishID: String, isLiked: Bool, isDisliked: Bool) {
        guard let index = dishes.firstIndex(where: { $0.id == dishID }) else { return }
        dishes[index].isLiked = isLiked
        dishes[index].isDisliked = isDisliked
        collectionRestaurantCell.reloadItems(at: [IndexPath(item: index, section: 0)])
    }
}
