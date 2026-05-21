import UIKit

protocol ITabBarFactory {
    static func makeMainTabBar(controllers: [UIViewController]) -> UITabBarController
}

final class TabBarFactory: ITabBarFactory {
    static func makeMainTabBar(controllers: [UIViewController]) -> UITabBarController {
        let tabBar = MainTabBarController()
        tabBar.viewControllers = controllers
        return tabBar
    }
}
