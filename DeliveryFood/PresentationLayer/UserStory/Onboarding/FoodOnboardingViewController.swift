//
//  FoodOnboardingViewController.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 4/9/25.

import UIKit

protocol FoodOnboardingViewControllerDelegate: AnyObject {
    func tapOnNextButton()
}

protocol FoodOnboardingViewControllerDataSource: AnyObject {
    func numberOfPageCount() -> Int
}

extension FoodOnboardingViewController {
    enum Constants {
        static let stackViewSide: CGFloat = 30
        static let stackViewHeight: CGFloat = 149
        static let pageControlHeight: CGFloat = 20
        
        static let buttonCornerRadius: CGFloat = 25
        static let buttonFontSize: CGFloat = 18
        static let stackViewSpacing: CGFloat = 20
    }
}

class FoodOnboardingViewController: UIViewController {
    
    private var delegate: FoodOnboardingViewControllerDelegate?
    private var dataSource: FoodOnboardingViewControllerDataSource?
    
    private let pageViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.backgroundColor = .brightGray
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constants.buttonFontSize, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPageIndicatorTintColor = .darkGray
        control.pageIndicatorTintColor = .lightGray
        control.translatesAutoresizingMaskIntoConstraints = false
        control.isUserInteractionEnabled = false
        return control
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let pageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        makeLayout()
        configure()
    }
    
    private func setupUI() {
        stackView.addArrangedSubview(nextButton)
        stackView.addArrangedSubview(pageControl)
        pageContainerView.addSubview(pageViewController.rootView)
        view.addSubview(stackView)
        view.addSubview(pageContainerView)
        addChild(pageViewController)
    }
    
    private func makeLayout() {
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackViewSide),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.stackViewSide),
            stackView.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight),
            
            pageContainerView.bottomAnchor.constraint(equalTo: stackView.topAnchor),
            pageContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pageContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pageContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            pageViewController.rootView.topAnchor.constraint(equalTo: pageContainerView.topAnchor),
            pageViewController.rootView.bottomAnchor.constraint(equalTo: pageContainerView.bottomAnchor),
            pageViewController.rootView.leadingAnchor.constraint(equalTo: pageContainerView.leadingAnchor),
            pageViewController.rootView.trailingAnchor.constraint(equalTo: pageContainerView.trailingAnchor)
        ])
    }
    
    private func configure() {
        view.backgroundColor = .tennéOrTawny
        delegate = pageViewController
        dataSource = pageViewController
        pageViewController.customDelegate = self
        pageControl.numberOfPages = dataSource?.numberOfPageCount() ?? 0
    }
    
    @objc private func nextButtonTapped() {
        delegate?.tapOnNextButton()
    }
}

extension FoodOnboardingViewController: PageViewControllerDelegate {
    func changePage(index: Int, model: PageViewControllerModel) {
        pageControl.currentPage = index
        nextButton.setTitle(model.textButton, for: .normal)
    }
}
