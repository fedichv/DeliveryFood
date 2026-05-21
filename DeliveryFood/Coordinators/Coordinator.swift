import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var uiNavigationController: UINavigationController? { get }
    var parent: Coordinator? { get set }
    func start()
}
