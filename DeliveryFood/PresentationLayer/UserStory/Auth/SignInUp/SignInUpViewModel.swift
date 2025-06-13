//
//  SignInUpViewModel.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 6/8/25.
//

import UIKit

final class SignInUpViewModel {
    private weak var coordinator: AuthCoordinator?

    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }

    func didTapSignIn() {
        coordinator?.open(screen: .signIn)
    }

    func didTapSignUp() {
        coordinator?.open(screen: .signUp)
    }
}
