//
//  TabBarCoordinator.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 5/13/25.
//
import UIKit

class TabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var uiNavigationController: UINavigationController?
    
    var parent: Coordinator?
    
    private var window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let homeViewModel = HomeScreenViewModel()
        let homeVC = HomeScreenViewController(viewModel: homeViewModel)
        homeViewModel.view = homeVC
        
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
        
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
    }
}
