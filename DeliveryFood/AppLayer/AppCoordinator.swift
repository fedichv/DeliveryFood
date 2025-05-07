//
//  AppCoordinator.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 5/3/25.
//
import UIKit

class AppCoordinator {
    weak var window: UIWindow?
    
    func start() {
        
        var navigationController: UINavigationController
        
        if true {
            let homeScreen = HomeScreenViewController()
            navigationController = UINavigationController(rootViewController: homeScreen)
            let tabBar = MainTabBarController()
            tabBar.viewControllers = [navigationController]
            window?.rootViewController = tabBar
            window?.makeKeyAndVisible()
        } else if UserDefaultsManager.shared.getBool(forKey: .isWatchedOnboarding) {
            let signInUpViewController = SignInUpViewController()
            navigationController = UINavigationController(rootViewController: signInUpViewController)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        } else {
            let onboardingVC = FoodOnboardingViewController()
            navigationController = UINavigationController(rootViewController: onboardingVC)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
        
        
    }
}
