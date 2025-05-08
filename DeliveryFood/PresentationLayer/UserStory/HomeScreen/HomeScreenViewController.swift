//
//  HomeScreenView.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 5/1/25.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
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
    private let sectionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Food Menu"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let viewAllLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "View All"
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        configure()
    }
    
    private func setupViews() {
        view.addSubview(searchField)
        view.addSubview(pinImage)
        view.addSubview(addressLabel)
        view.addSubview(sectionLabel)
        view.addSubview(viewAllLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            searchField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchField.widthAnchor.constraint(equalToConstant: 354),
            searchField.heightAnchor.constraint(equalToConstant: 50),
            
            pinImage.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 16),
            pinImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            pinImage.widthAnchor.constraint(equalToConstant: 20),
            pinImage.heightAnchor.constraint(equalToConstant: 20),
            
            addressLabel.centerYAnchor.constraint(equalTo: pinImage.centerYAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: pinImage.trailingAnchor, constant: 10),
            
            sectionLabel.topAnchor.constraint(equalTo: pinImage.bottomAnchor, constant: 24),
            sectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            viewAllLabel.centerYAnchor.constraint(equalTo: sectionLabel.centerYAnchor),
            viewAllLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    private func configure() {
        view.backgroundColor = .white
    }
}
