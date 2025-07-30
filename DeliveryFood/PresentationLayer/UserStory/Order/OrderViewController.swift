//
//  OrderView.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 5/1/25.
//
import UIKit

class OrderViewController: UIViewController {
    
    private var orders: [OrderDishModel] = []
    
    private let dishCollection: UICollectionView = {
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
        view.backgroundColor = .white
        configure()
        setupViews()
        setupConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(cartDidUpdate), name: .cartUpdated, object: nil)
        
        // Инициализация данных
        orders = CartManager.shared.items
    }
    
    private func configure() {
        title = "Your Order"
        dishCollection.dataSource = self
        dishCollection.delegate = self
        
        dishCollection.register(OrderCellDish.self, forCellWithReuseIdentifier: "OrderCellDish")
    }
    
    private func setupViews() {
        view.addSubview(dishCollection)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dishCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dishCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dishCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dishCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc private func cartDidUpdate() {
        orders = CartManager.shared.items
        dishCollection.reloadData()
    }
    
    // UICollectionViewDataSource и Delegate остаются без изменений
}

// MARK: - UICollectionViewDataSource

extension OrderViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderCellDish", for: indexPath) as? OrderCellDish else {
            return UICollectionViewCell()
        }
        
        let order = orders[indexPath.row]
        cell.configure(with: order)
        
        return cell
    }
}

