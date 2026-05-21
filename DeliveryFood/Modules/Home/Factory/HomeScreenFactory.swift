import UIKit

final class HomeScreenFactory {
    static func makeHomeScreen() -> UIViewController {
        let viewModel = HomeScreenViewModel()
        let viewController = HomeScreenViewController(viewModel: viewModel)
        viewModel.view = viewController
        return viewController
    }
}
