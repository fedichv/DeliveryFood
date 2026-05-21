import Foundation

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
