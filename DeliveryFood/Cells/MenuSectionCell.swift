import UIKit

struct MenuSectionCellModel {
    var title: String
    var image: UIImage
}

class MenuSectionCell: UICollectionViewCell {
    static let reuseIdentifier = "MenuSectionCell"

    private let imageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .brightGray
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupViews() {
        contentView.addSubview(verticalStack)
        imageContainer.addSubview(imageView)
        verticalStack.addArrangedSubview(imageContainer)
        verticalStack.addArrangedSubview(titleLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            imageContainer.widthAnchor.constraint(equalToConstant: 70),
            imageContainer.heightAnchor.constraint(equalToConstant: 70),

            imageView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    func configure(with model: MenuSectionCellModel) {
        titleLabel.text = model.title
        imageView.image = model.image
    }
}
