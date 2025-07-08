//
//  DishViewController .swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 7/2/25.
//

import UIKit

class DishViewController: UIViewController {
    
    private weak var viewModel: RestaurantViewOutput?
    
//    private let sectionTitle: String
//    init(sectionTitle: String, viewModel: RestaurantViewOutput? = nil) {
//        self.sectionTitle = sectionTitle
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    private let collectionRestaurantCell: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 352, height: 80)
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        configure()
        setupViews()
        setupConstraints()
    }
    
    private func configure() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = "Dogmie jagong tutung"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
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
            collectionRestaurantCell.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionRestaurantCell.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionRestaurantCell.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
extension DishViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCell.reuseIdentifier, for: indexPath) as? DishCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
}
extension DishViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("нажата ячейка блюда \(indexPath.item)")
        let detailVC = DescriptionViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
