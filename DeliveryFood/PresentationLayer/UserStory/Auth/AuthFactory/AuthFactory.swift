//
//  AuthFactory.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 6/8/25.
//

import UIKit

final class AuthFactory {
    static func makeAuthViewController(mode: AuthMode,coordinator: AuthCoordinator) -> AuthViewController {
        
        let authVC = AuthViewController(authMode: mode)
        let viewModel = AuthViewModel(view: authVC, coordinator: coordinator)
        authVC.viewModel = viewModel
        
        return authVC
    }
}
