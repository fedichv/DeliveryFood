import UIKit

final class OnboardingCoordinator: Coordinator {
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
