//
//  ProfileView.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 5/1/25.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "man")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Dude"
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()

    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "+7 123 456 78 90"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()

    private let options = [
        "My Profile",
        "Change Password",
        "Payment Settings",
        "My Voucher",
        "Notification",
        "About Us",
        "Contact Us"
    ]
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: optionButtons)
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var optionButtons: [UIView] {
        return options.map { title in
            let view = makeOptionRow(title: title)
            return view
        }
    }
    
    private let signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup
    
    private func configure() {
        view.backgroundColor = .white
    }

    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [avatarImageView, nameLabel, phoneLabel, stackView, signOutButton].forEach {
            contentView.addSubview($0)
        }
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // scrollView & contentView
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // avatar
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 162),
            avatarImageView.heightAnchor.constraint(equalToConstant: 162),
            
            // name & phone
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            phoneLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            // stackView
            stackView.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            // signOutButton
            signOutButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            signOutButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            signOutButton.heightAnchor.constraint(equalToConstant: 44),
            signOutButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            signOutButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            signOutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    // MARK: - Helpers
    
    private func makeOptionRow(title: String) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 16)
        
        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevron.tintColor = .lightGray
        
        let hStack = UIStackView(arrangedSubviews: [label, chevron])
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.distribution = .equalSpacing
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            hStack.topAnchor.constraint(equalTo: container.topAnchor),
            hStack.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        return container
    }
}
