import UIKit

final class SignInUpCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var uiNavigationController: UINavigationController?
    var parent: Coordinator?

    private var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let signInUpVC = SignInUpViewController()
        let navigationController = UINavigationController(rootViewController: signInUpVC)
        self.uiNavigationController = navigationController

        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator.parent = self
        childCoordinators.append(authCoordinator)

        let viewModel = SignInUpViewModel(coordinator: authCoordinator)
        signInUpVC.viewModel = viewModel

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
