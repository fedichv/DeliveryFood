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

    // MARK: - UI Elements

    private let imageOnboarding: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let onboardingTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.titleFontSize, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let ondoardingDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.descriptionFontSize)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle

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

    // MARK: - Configuration

    func configure(imageName: String, onboardingTitle: String, ondoardingDescription: String, button: String) {
        imageOnboarding.image = UIImage(named: imageName)
        self.onboardingTitle.text = onboardingTitle
        self.ondoardingDescription.text = ondoardingDescription
    }
}
