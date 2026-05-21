import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .tennéOrTawny
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = .white
        tabBar.clipsToBounds = true
    }
}
