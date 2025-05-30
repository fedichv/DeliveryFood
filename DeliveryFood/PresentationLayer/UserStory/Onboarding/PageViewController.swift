//
//  PageViewController.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 3/30/25.
//

import UIKit

// MARK: - Models

struct PageViewControllerModel {
    var identifier = "PageViewController"
    let imageName: String
    let title: String
    let description: String
    let textButton: String
}

struct OnboardingConstants {
    static let pages: [PageViewControllerModel] = [
        PageViewControllerModel(
            imageName: "chicken-leg",
            title: "Delicious Food",
            description: "Lorem ipsum dolor sit amet, consectetur \n adipiscing elit.",
            textButton: "Next"
        ),
        PageViewControllerModel(
            imageName: "shipped",
            title: "Fast Shipping",
            description: "Lorem ipsum dolor sit amet, consectetur\n adipiscing elit. Interdum rhoncus nulla.",
            textButton: "Next"
        ),
        PageViewControllerModel(
            imageName: "medal",
            title: "Certificate Food",
            description: "Lorem ipsum dolor sit amet, consectetur\n adipiscing elit. Morbi ultricies mauris a id.",
            textButton: "Cool!"
        ),
    ]
}

// MARK: - Protocols

protocol PageViewControllerDelegate: AnyObject {
    func changePage(index: Int, model: PageViewControllerModel)
    func didFinishOnboarding()
}

// MARK: - PageViewController

class PageViewController: UIPageViewController {
    
    // MARK: - Properties
    
    var rootView: UIView {
        view
    }
    
    weak var customDelegate: PageViewControllerDelegate?
    
    private var pages: [FoodPageContentViewController] = []
    private var currentIndex = 0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        setupPages()
        setInitialPage()
    }
    
    // MARK: - Setup
    
    private func setupPages() {
        for model in OnboardingConstants.pages {
            let contentVC = FoodPageContentViewController()
            contentVC.configure(
                imageName: model.imageName,
                onboardingTitle: model.title,
                ondoardingDescription: model.description,
                button: model.textButton
            )
            pages.append(contentVC)
        }
    }
    
    private func setInitialPage() {
        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
            customDelegate?.changePage(index: currentIndex, model: OnboardingConstants.pages[currentIndex])
        }
    }
    
    // MARK: - Navigation
    
    private func goToNextPage() {
        let nextIndex = currentIndex + 1
        guard nextIndex < pages.count else {
            goToSignInUpVC()
            return
        }
        
        setViewControllers([pages[nextIndex]], direction: .forward, animated: true, completion: nil)
        currentIndex = nextIndex
        customDelegate?.changePage(index: currentIndex, model: OnboardingConstants.pages[currentIndex])
    }
    
    private func goToSignInUpVC() {
        UserDefaultsManager.shared.set(true, forKey: .isWatchedOnboarding)
        
        let signInUpVC = SignInUpViewController()
        navigationController?.pushViewController(signInUpVC, animated: true)
    }
}

// MARK: - UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController as! FoodPageContentViewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController as! FoodPageContentViewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else {
            return nil
        }
        
        return pages[nextIndex]
    }
}

// MARK: - UIPageViewControllerDelegate

extension PageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        
        guard completed,
              let currentVC = pageViewController.viewControllers?.first,
              let index = pages.firstIndex(of: currentVC as! FoodPageContentViewController) else {
            return
        }
        
        currentIndex = index
        customDelegate?.changePage(index: currentIndex, model: OnboardingConstants.pages[currentIndex])
    }
}

// MARK: - FoodOnboardingViewControllerDelegate

extension PageViewController: FoodOnboardingViewControllerDelegate {
    
    func didFinishOnboarding() {
        goToSignInUpVC()
    }
    
    func tapOnNextButton() {
        if currentIndex == pages.count - 1 {
            customDelegate?.didFinishOnboarding()
        } else {
            goToNextPage()
        }
    }
}

// MARK: - FoodOnboardingViewControllerDataSource

extension PageViewController: FoodOnboardingViewControllerDataSource {
    
    func numberOfPageCount() -> Int {
        pages.count
    }
}
