import UIKit

final class OrderFactory {
    static func makeOrderScreen() -> UIViewController {
        return OrderViewController()
    }
}
