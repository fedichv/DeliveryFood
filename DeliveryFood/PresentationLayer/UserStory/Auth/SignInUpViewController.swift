//
//  SignInUpViewController.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 4/16/25.
//

import UIKit


private let imageSignInUpView: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.image = UIImage(named: "SignInUp")
    return image
}()

private let imageDishView: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.image = UIImage(named: "Dish")
    image.contentMode = .scaleAspectFit
    image.clipsToBounds = true
    return image
}()

private var signInButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 25
    button.backgroundColor = .tennéOrTawny
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    button.setTitle("Sign In", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    //    button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    return button
}()

private var signUpButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 25
    button.backgroundColor = .brightGray
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    button.setTitle("Sign Up", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    //    button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    return button
}()

private let stackSignInUpView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.spacing = 20
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
}()

class SignInUpViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        configure()
    }
    
    private func setupViews() {
        
        view.addSubview(imageSignInUpView)
        view.addSubview(stackSignInUpView)
        view.addSubview(imageDishView)
        
        stackSignInUpView.addArrangedSubview(signInButton)
        stackSignInUpView.addArrangedSubview(signUpButton)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageSignInUpView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            imageSignInUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageSignInUpView.heightAnchor.constraint(equalToConstant: 300),
            imageSignInUpView.widthAnchor.constraint(equalToConstant: 300),
            
            stackSignInUpView.topAnchor.constraint(equalTo: imageSignInUpView.bottomAnchor, constant: 60),
            stackSignInUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackSignInUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackSignInUpView.heightAnchor.constraint(equalToConstant: 120),
            
            imageDishView.leadingAnchor.constraint(equalTo: view.leadingAnchor), 
            imageDishView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageDishView.widthAnchor.constraint(equalToConstant: 200),
            imageDishView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    private func configure() {
        view.backgroundColor = .white
    }
}
