import UIKit

final class AuthCoordinator: Coordinator {

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
        open(screen: .signUp)
    }

    func open(screen: AuthCoordinatorScreen) {
        switch screen {
        case .signIn:
            let vc = AuthViewController(authMode: .signIn)
            let vm = AuthViewModel(view: vc, coordinator: self)
            vc.output = vm
            uiNavigationController?.setViewControllers([vc], animated: true)

        case .signUp:
            let vc = AuthViewController(authMode: .signUp)
            let vm = AuthViewModel(view: vc, coordinator: self)
            vc.output = vm
            uiNavigationController?.setViewControllers([vc], animated: true)

        case .home:
            guard let window = uiNavigationController?.view.window else { return }
            let coordinator = TabBarCoordinator(window: window)
            coordinator.parent = self
            childCoordinators.append(coordinator)
            coordinator.start()
        }
    }
}
