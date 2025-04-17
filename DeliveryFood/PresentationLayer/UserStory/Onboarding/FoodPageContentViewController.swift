//
//  ViewController.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 3/27/25.
//

import UIKit

extension FoodPageContentViewController {
    enum Constants {
        static let imageSize: CGFloat = 200
        static let imageVerticalOffset: CGFloat = -50
        static let titleTopOffset: CGFloat = 20
        static let descriptionTopOffset: CGFloat = 23
        static let descriptionSideInset: CGFloat = 40
        static let descriptionBottomInset: CGFloat = -20
        static let titleFontSize: CGFloat = 24
        static let descriptionFontSize: CGFloat = 14
    }
}

class FoodPageContentViewController: UIViewController {
    
    private let imageOnboarding: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let onboardingTitle: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: Constants.titleFontSize, weight: .bold)
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let ondoardingDescription: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: Constants.descriptionFontSize)
        title.textColor = .white
        title.numberOfLines = 0
        title.textAlignment = .center
        title.lineBreakMode = .byWordWrapping
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(imageOnboarding)
        view.addSubview(onboardingTitle)
        view.addSubview(ondoardingDescription)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageOnboarding.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: Constants.imageVerticalOffset),
            imageOnboarding.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageOnboarding.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            imageOnboarding.heightAnchor.constraint(equalToConstant: Constants.imageSize),
            
            onboardingTitle.topAnchor.constraint(equalTo: imageOnboarding.bottomAnchor, constant: Constants.titleTopOffset),
            onboardingTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            ondoardingDescription.topAnchor.constraint(equalTo: onboardingTitle.bottomAnchor, constant: Constants.descriptionTopOffset),
            ondoardingDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.descriptionSideInset),
            ondoardingDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.descriptionSideInset),
            ondoardingDescription.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: Constants.descriptionBottomInset),
        ])
    }
    
    func configure(imageName: String, onboardingTitle: String, ondoardingDescription: String, button: String) {
        imageOnboarding.image = UIImage(named: imageName)
        self.onboardingTitle.text = onboardingTitle
        self.ondoardingDescription.text = ondoardingDescription
    }
}
