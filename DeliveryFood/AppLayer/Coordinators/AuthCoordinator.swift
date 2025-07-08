//
//  AuthCoordinator.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 6/5/25.
//

import UIKit

class AuthCoordinator: Coordinator {
    enum AuthCoordinatorScreen {
        case signIn
        case signUp
        case home
    }
    
    var childCoordinators: [Coordinator] = []
    var uiNavigationController: UINavigationController?
    var parent: Coordinator?

    init(navigationController: UINavigationController) {
        self.uiNavigationController = navigationController
    }
    
    func start() {
        // Запускаем с экрана SignUp, если нужно
        open(screen: .signUp)
    }
    
    func open(screen: AuthCoordinatorScreen) {
        switch screen {
        case .signIn:
            let signInVC = AuthViewController(authMode: .signIn)
            let viewModel = AuthViewModel(view: signInVC, coordinator: self)
            signInVC.output = viewModel
            uiNavigationController?.setViewControllers([signInVC], animated: true)
            
        case .signUp:
            let signUpVC = AuthViewController(authMode: .signUp)
            let viewModel = AuthViewModel(view: signUpVC, coordinator: self)
            signUpVC.output = viewModel
            uiNavigationController?.setViewControllers([signUpVC], animated: true)
        case .home:
            guard let window = uiNavigationController?.view.window else { return }
            let tabBarCoordinator = TabBarCoordinator(window: window)
            tabBarCoordinator.parent = self
            childCoordinators.append(tabBarCoordinator)
            tabBarCoordinator.start()
        }
    }
}
