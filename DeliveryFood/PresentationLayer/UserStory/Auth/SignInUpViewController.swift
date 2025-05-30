//
//  SignInUpViewController.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 4/16/25.
//

import UIKit

// MARK: - Constants
extension SignInUpViewController {
    enum Constants {
        static let logoImageName = "logoSignInUp"
        static let dishImageName = "Dish"

        static let signInTitle = "Sign In"
        static let signUpTitle = "Sign Up"

        static let buttonCornerRadius: CGFloat = 25
        static let buttonFontSize: CGFloat = 18

        static let stackViewSpacing: CGFloat = 20
        static let stackTopOffset: CGFloat = 30
        static let stackSideInset: CGFloat = 30
        static let stackHeight: CGFloat = 120

        static let logoTopOffset: CGFloat = 16
        static let logoSize: CGFloat = 300

        static let dishLeadingInset: CGFloat = -15
        static let dishWidth: CGFloat = 200
        static let dishHeight: CGFloat = 100
    }
}

// MARK: - SignInUpViewController

final class SignInUpViewController: UIViewController {

    // MARK: - UI Elements

    private let imageSignInUpView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: Constants.logoImageName)
        return image
    }()

    private let imageDishView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: Constants.dishImageName)
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()

    private let signInButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.backgroundColor = .tennéOrTawny
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constants.buttonFontSize, weight: .bold)
        button.setTitle(Constants.signInTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let signUpButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.backgroundColor = .brightGray
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constants.buttonFontSize, weight: .bold)
        button.setTitle(Constants.signUpTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let stackSignInUpView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        configure()

        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaultsManager.shared.set(true, forKey: .isWatchedOnboarding)
    }
    
    // MARK: - Setup Methods

    private func setupViews() {
        view.addSubview(imageSignInUpView)
        view.addSubview(stackSignInUpView)
        view.addSubview(imageDishView)

        stackSignInUpView.addArrangedSubview(signInButton)
        stackSignInUpView.addArrangedSubview(signUpButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageSignInUpView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.logoTopOffset),
            //imageSignInUpView.topAnchor.constraint(equalTo: , equal: Constants.logoTopOffset),
            imageSignInUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageSignInUpView.heightAnchor.constraint(equalToConstant: Constants.logoSize),
            imageSignInUpView.widthAnchor.constraint(equalToConstant: Constants.logoSize),

            stackSignInUpView.topAnchor.constraint(equalTo: imageSignInUpView.bottomAnchor, constant: Constants.stackTopOffset),
            stackSignInUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackSideInset),
            stackSignInUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.stackSideInset),
            stackSignInUpView.heightAnchor.constraint(equalToConstant: Constants.stackHeight),

            imageDishView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.dishLeadingInset),
            imageDishView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageDishView.widthAnchor.constraint(equalToConstant: Constants.dishWidth),
            imageDishView.heightAnchor.constraint(equalToConstant: Constants.dishHeight)
        ])
    }

    // MARK: - Configuration

    private func configure() {
        view.backgroundColor = .white
    }

    // MARK: - Actions

    @objc private func didTapSignIn() {
        let authVC = AuthViewController(authMode: .signIn)
        navigationController?.pushViewController(authVC, animated: true)
    }

    @objc private func didTapSignUp() {
        let authVC = AuthViewController(authMode: .signUp)
        navigationController?.pushViewController(authVC, animated: true)
    }
}
