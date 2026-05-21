import UIKit

final class TabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var uiNavigationController: UINavigationController?
    var parent: Coordinator?

    private var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let homeVC = HomeScreenFactory.makeHomeScreen()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "store"), tag: 0)

        let orderVC = OrderFactory.makeOrderScreen()
        orderVC.tabBarItem = UITabBarItem(title: "Order", image: UIImage(named: "shopping-list"), tag: 1)

        let myListVC = MyListFactory.makeMyListScreen()
        myListVC.tabBarItem = UITabBarItem(title: "My List", image: UIImage(named: "rectangle"), tag: 2)

        let profileVC = ProfileFactory.makeProfileScreen()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "user"), tag: 3)

        let tabBar = TabBarFactory.makeMainTabBar(controllers: [
            UINavigationController(rootViewController: homeVC),
            UINavigationController(rootViewController: orderVC),
            UINavigationController(rootViewController: myListVC),
            UINavigationController(rootViewController: profileVC)
        ])

        window.rootViewController = tabBar
        window.makeKeyAndVisible()
    }
}
