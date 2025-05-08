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
        
        let homeVC = HomeScreenViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "store"), tag: 0)
        
        let orderVC = OrderViewController()
        orderVC.tabBarItem = UITabBarItem(title: "Order", image: UIImage(named: "shopping-list"), tag: 1)
        
        let myListVC = MyListViewController()
        myListVC.tabBarItem = UITabBarItem(title: "My List", image: UIImage(named: "rectangle"), tag: 2)
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "user"), tag: 3)
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let orderNav = UINavigationController(rootViewController: orderVC)
        let myListNav = UINavigationController(rootViewController: myListVC)
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        let tabBar = MainTabBarController()
        tabBar.viewControllers = [homeNav, orderNav, myListNav, profileNav]
        
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        //        } else if UserDefaultsManager.shared.getBool(forKey: .isWatchedOnboarding) {
        //            let signInUpViewController = SignInUpViewController()
        //            navigationController = UINavigationController(rootViewController: signInUpViewController)
        //            window?.rootViewController = navigationController
        //            window?.makeKeyAndVisible()
        //        } else {
        //            let onboardingVC = FoodOnboardingViewController()
        //            navigationController = UINavigationController(rootViewController: onboardingVC)
        //            window?.rootViewController = navigationController
        //            window?.makeKeyAndVisible()
        //        }
        //
        //
        //    }
    }
}
