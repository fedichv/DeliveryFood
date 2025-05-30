//
//  AppCoordinator.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 5/3/25.
//
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var uiNavigationController: UINavigationController? { get }
    var parent: Coordinator? { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var uiNavigationController: UINavigationController?
    
    var parent: Coordinator?
    
    private var window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if !UserDefaultsManager.shared.getBool(forKey: .isWatchedOnboarding) {
            let onboardingCoordinator = OnboardingCoordinator(window: window)
            onboardingCoordinator.parent = self
            childCoordinators.append(onboardingCoordinator)
            onboardingCoordinator.start()
//        } else if !UserDefaultsManager.shared.getBool(forKey: .isLoggedIn) {
//            let signInUpCoordinator = SignInUpCoordinator(window: window)
//            signInUpCoordinator.parent = self
//            childCoordinators.append(signInUpCoordinator)
//            signInUpCoordinator.start()
        } else {
            let tabBar = TabBarCoordinator(window: window)
            tabBar.parent = self
            childCoordinators.append(tabBar)
            tabBar.start()
        }
    }
}
