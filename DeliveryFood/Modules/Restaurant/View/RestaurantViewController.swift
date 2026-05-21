import UIKit

protocol RestaurantViewOutput: AnyObject {
    func didChangeSearchText(_ text: String)
}

class RestaurantViewController: UIViewController {

    private weak var viewModel: RestaurantViewOutput?
    private let sectionTitle: String

    init(sectionTitle: String, viewModel: RestaurantViewOutput? = nil) {
        self.sectionTitle = sectionTitle
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - UI Elements

    private let searchField: UITextField = {
        let tf = PaddedTextField()
        tf.placeholder = "Search"
        tf.textColor = .darkGray
        tf.layer.cornerRadius = 25
        tf.backgroundColor = .brightGray
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private let collectionRestaurantCell: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 320, height: 130)
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = true
        return cv
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        configure()
        setupViews()
        setupConstraints()
        hideKeyboardWhenTappedAround()
    }

    // MARK: - Setup

    private func configure() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let titleLabel = UILabel()
        titleLabel.text = sectionTitle
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
        navigationItem.titleView = titleLabel

        searchField.delegate = self

        collectionRestaurantCell.register(RestaurantCell.self, forCellWithReuseIdentifier: RestaurantCell.reuseIdentifier)
        collectionRestaurantCell.dataSource = self
        collectionRestaurantCell.delegate = self
    }

    private func setupViews() {
        view.addSubview(searchField)
        view.addSubview(collectionRestaurantCell)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchField.widthAnchor.constraint(equalToConstant: 354),
            searchField.heightAnchor.constraint(equalToConstant: 50),

            collectionRestaurantCell.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 20),
            collectionRestaurantCell.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionRestaurantCell.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionRestaurantCell.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension RestaurantViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 50 }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCell.reuseIdentifier, for: indexPath) as? RestaurantCell else { return UICollectionViewCell() }
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension RestaurantViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(DishViewController(), animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension RestaurantViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder(); return true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel?.didChangeSearchText(textField.text ?? "")
    }
}
