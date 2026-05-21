import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var uiNavigationController: UINavigationController?
    var parent: Coordinator?

    private var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        if !UserDefaultsManager.shared.getBool(forKey: .isWatchedOnboarding) {
            let coordinator = OnboardingCoordinator(window: window)
            coordinator.parent = self
            childCoordinators.append(coordinator)
            coordinator.start()
        } else if !UserDefaultsManager.shared.getBool(forKey: .isLoggedIn) {
            let coordinator = SignInUpCoordinator(window: window)
            coordinator.parent = self
            childCoordinators.append(coordinator)
            coordinator.start()
        } else {
            showMainTabBar()
        }
    }

    func showMainTabBar() {
        let coordinator = TabBarCoordinator(window: window)
        coordinator.parent = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
