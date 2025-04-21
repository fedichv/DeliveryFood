//
//  AuthViewController.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 4/20/25.
//
import UIKit

enum AuthMode: String {
    case signIn = "Sign In"
    case signUp = "Sign Up"
}

final class AuthViewController: UIViewController {
    
    
    
    private let titleSignInOrSignUp: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 24, weight: .bold)
        title.text = "Sign In"
        title.textColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    private let textFieldUsername: UITextField = {
        let usernameTextField = PaddedTextField()
        usernameTextField.placeholder = "Username"
        usernameTextField.layer.cornerRadius = 25
        usernameTextField.backgroundColor = .brightGray
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        return usernameTextField
    }()
    private let textFieldPassword: UITextField = {
        let passwordTextField = PaddedTextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.cornerRadius = 25
        passwordTextField.backgroundColor = .brightGray
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextField
    }()
    private let textFieldReEnterPassword: UITextField = {
        let reEnterPasswordTextField = PaddedTextField()
        reEnterPasswordTextField.placeholder = "Re-enter password"
        reEnterPasswordTextField.layer.cornerRadius = 25
        reEnterPasswordTextField.backgroundColor = .brightGray
        reEnterPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        reEnterPasswordTextField.isHidden = true
        return reEnterPasswordTextField
    }()
    
    private let signInOrSignUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .tennéOrTawny
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let imageDishView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Dish")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleSignInOrSignUp)
        stackView.addArrangedSubview(textFieldUsername)
        stackView.addArrangedSubview(textFieldPassword)
        stackView.addArrangedSubview(textFieldReEnterPassword)
        stackView.addArrangedSubview(signInOrSignUpButton)
        view.addSubview(imageDishView)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            titleSignInOrSignUp.heightAnchor.constraint(equalToConstant: 28),
            
            textFieldUsername.heightAnchor.constraint(equalToConstant: 50),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 50),
            textFieldReEnterPassword.heightAnchor.constraint(equalToConstant: 50),
            signInOrSignUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            imageDishView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -15),
            imageDishView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageDishView.widthAnchor.constraint(equalToConstant: 200),
            imageDishView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    private func configure() {
        view.backgroundColor = .white
    }
}

