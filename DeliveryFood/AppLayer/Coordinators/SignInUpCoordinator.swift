//
//  SignInUpCoordinator.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 5/13/25.
//
import UIKit

class SignInUpCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var uiNavigationController: UINavigationController?
    
    var parent: Coordinator?
    
    private var window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let signInUpViewController = SignInUpViewController()
        uiNavigationController = UINavigationController(rootViewController: signInUpViewController)
        window.rootViewController = uiNavigationController
        window.makeKeyAndVisible()
    }
}
