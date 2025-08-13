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
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .tennéOrTawny
        button.layer.cornerRadius = 25
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        setupViews()
        setupConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(cartDidUpdate), name: .cartUpdated, object: nil)
        
        orders = CartManager.shared.items
        
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    private func configure() {
        title = "Review Food"
        dishCollection.dataSource = self
        dishCollection.delegate = self
        dishCollection.register(OrderCellDish.self, forCellWithReuseIdentifier: "OrderCellDish")
    }
    
    private func setupViews() {
        view.addSubview(dishCollection)
        view.addSubview(sendButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dishCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dishCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dishCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dishCollection.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -16),
            
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            sendButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func cartDidUpdate() {
        orders = CartManager.shared.items
        dishCollection.reloadData()
    }
    
    @objc private func sendButtonTapped() {
        print("Send button tapped")
        
    }
    
    @objc private func deleteDish(_ sender: UIButton) {
        guard let cell = sender.superview(of: OrderCellDish.self),
              let indexPath = dishCollection.indexPath(for: cell) else { return }

        dishCollection.performBatchUpdates {
            dishCollection.deleteItems(at: [indexPath])
            
            let removedDish = orders.remove(at: indexPath.item)
            CartManager.shared.remove(item: removedDish)
        }
    }
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
        cell.setDeleteAction(target: self, action: #selector(deleteDish(_:)))

        return cell
    }
}
