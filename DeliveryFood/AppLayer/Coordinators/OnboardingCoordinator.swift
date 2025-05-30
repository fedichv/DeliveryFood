//
//  OnboardingCoordinator.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 5/13/25.
//

import UIKit


class OnboardingCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var uiNavigationController: UINavigationController?
    
    var parent: Coordinator?
    
    private var window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let onboardingVC = FoodOnboardingViewController()
        uiNavigationController = UINavigationController(rootViewController: onboardingVC)
        window.rootViewController = uiNavigationController
        window.makeKeyAndVisible()
    }
}
