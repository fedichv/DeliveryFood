//
//  RestaurantViewController.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 6/23/25.
//

import UIKit
protocol RestaurantViewOutput: AnyObject {
    func didChangeSearchText(_ text: String)
}

class RestaurantViewController: UIViewController {
    
    private weak var viewModel: RestaurantViewOutput?
    
    private let sectionTitle: String
    init(sectionTitle: String, viewModel: RestaurantViewOutput? = nil) {
        self.sectionTitle = sectionTitle
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let searchField: UITextField = {
        let textField = PaddedTextField()
        textField.placeholder = "Search"
        textField.textColor = .darkGray
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .brightGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let collectionRestaurantCell: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 320, height: 130)
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
        hideKeyboardWhenTappedAround()
    }
    
    private func configure() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = sectionTitle
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
        navigationItem.titleView = titleLabel
        
        searchField.delegate = self
        
        collectionRestaurantCell.register(RestaurantCell.self, forCellWithReuseIdentifier: RestaurantCell.reuseIdentifier)
        collectionRestaurantCell.dataSource = self
        collectionRestaurantCell.delegate = self
    }
    
    private func setupViews() {
        view.addSubview(searchField)
        view.addSubview(collectionRestaurantCell)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide .topAnchor, constant: 10),
            searchField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchField.widthAnchor.constraint(equalToConstant: 354),
            searchField.heightAnchor.constraint(equalToConstant: 50),
            
            collectionRestaurantCell.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 20),
            collectionRestaurantCell.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionRestaurantCell.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionRestaurantCell.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
extension RestaurantViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCell.reuseIdentifier, for: indexPath) as? RestaurantCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
}
extension RestaurantViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("нажата ячейка блюда \(indexPath.item)")
        let detailVC = DishViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
extension RestaurantViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel?.didChangeSearchText(textField.text ?? "")
    }
}
