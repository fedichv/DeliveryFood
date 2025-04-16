//
//  ViewController.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 3/27/25.
//

import UIKit

class FoodPageContentViewController: UIViewController {
    
    private let imageOnboarding: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let onboardingTitle: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 24, weight: .bold)
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let ondoardingDescription: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 14)
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
            imageOnboarding.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            imageOnboarding.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageOnboarding.widthAnchor.constraint(equalToConstant: 200),
            imageOnboarding.heightAnchor.constraint(equalToConstant: 200),
            
            onboardingTitle.topAnchor.constraint(equalTo: imageOnboarding.bottomAnchor, constant: 20),
            onboardingTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            ondoardingDescription.topAnchor.constraint(equalTo: onboardingTitle.bottomAnchor, constant: 23),
            ondoardingDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            ondoardingDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            ondoardingDescription.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20),
        ])
    }
    
    func configure(imageName: String, onboardingTitle: String, ondoardingDescription: String, button: String) {
        imageOnboarding.image = UIImage(named: imageName)
        self.onboardingTitle.text = onboardingTitle
        self.ondoardingDescription.text = ondoardingDescription
    }
}
