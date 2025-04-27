//
//  AuthViewController.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 4/20/25.
//
import UIKit

// MARK: - Constants
extension AuthViewController {
    enum Constants {
        static let signInTitle = "Sign In"
        static let signUpTitle = "Sign Up"
        
        static let usernamePlaceholder = "Username"
        static let passwordPlaceholder = "Password"
        static let reenterPasswordPlaceholder = "Re-enter password"
        
        static let cornerRadius: CGFloat = 25
        static let buttonFontSize: CGFloat = 18
        static let titleFontSize: CGFloat = 24
        static let stackSpacing: CGFloat = 20
        
        static let sideInset: CGFloat = 30
        static let textFieldHeight: CGFloat = 50
        static let buttonHeight: CGFloat = 50
        static let titleHeight: CGFloat = 28
        
        static let dishImageName = "Dish"
        static let dishImageLeadingInset: CGFloat = -15
        static let dishImageWidth: CGFloat = 200
        static let dishImageHeight: CGFloat = 100
        
        static let backButtonTopInset: CGFloat = 30
        static let backButtonSize: CGFloat = 20
    }
}


enum AuthMode: String {
    case signIn = "Sign In"
    case signUp = "Sign Up"
}

final class AuthViewController: UIViewController {
    
    private let authMode: AuthMode
    
    init(authMode: AuthMode) {
        self.authMode = authMode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleSignInOrSignUp: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: Constants.titleFontSize, weight: .bold)
        title.text = Constants.signInTitle
        title.textColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let textFieldUsername: UITextField = {
        let tf = PaddedTextField()
        tf.placeholder = Constants.usernamePlaceholder
        tf.layer.cornerRadius = Constants.cornerRadius
        tf.backgroundColor = .brightGray
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let textFieldPassword: UITextField = {
        let tf = PaddedTextField()
        tf.placeholder = Constants.passwordPlaceholder
        tf.layer.cornerRadius = Constants.cornerRadius
        tf.backgroundColor = .brightGray
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let textFieldReEnterPassword: UITextField = {
        let tf = PaddedTextField()
        tf.placeholder = Constants.reenterPasswordPlaceholder
        tf.layer.cornerRadius = Constants.cornerRadius
        tf.backgroundColor = .brightGray
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.isHidden = true
        return tf
    }()
    
    private let signInOrSignUpButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.signInTitle, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: Constants.buttonFontSize)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .tennéOrTawny
        button.layer.cornerRadius = Constants.cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = Constants.stackSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let imageDishView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: Constants.dishImageName)
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupViews()
        setupConstraints()
        configureForAuthMode()
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        view.addSubview(imageDishView)
        
        stackView.addArrangedSubview(titleSignInOrSignUp)
        stackView.addArrangedSubview(textFieldUsername)
        stackView.addArrangedSubview(textFieldPassword)
        stackView.addArrangedSubview(textFieldReEnterPassword)
        stackView.addArrangedSubview(signInOrSignUpButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideInset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideInset),

            titleSignInOrSignUp.heightAnchor.constraint(equalToConstant: Constants.titleHeight),
            textFieldUsername.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            textFieldPassword.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            textFieldReEnterPassword.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            signInOrSignUpButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),

            imageDishView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.dishImageLeadingInset),
            imageDishView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageDishView.widthAnchor.constraint(equalToConstant: Constants.dishImageWidth),
            imageDishView.heightAnchor.constraint(equalToConstant: Constants.dishImageHeight)
        ])
    }
    
    private func configure() {
        view.backgroundColor = .white
    }
    
    private func configureForAuthMode() {
        switch authMode {
        case .signIn:
            titleSignInOrSignUp.text = Constants.signInTitle
            signInOrSignUpButton.setTitle(Constants.signInTitle, for: .normal)
            textFieldReEnterPassword.isHidden = true
        case .signUp:
            titleSignInOrSignUp.text = Constants.signUpTitle
            signInOrSignUpButton.setTitle(Constants.signUpTitle, for: .normal)
            textFieldReEnterPassword.isHidden = false
        }
    }
}
