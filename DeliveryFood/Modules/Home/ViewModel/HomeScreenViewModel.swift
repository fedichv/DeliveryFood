import UIKit

final class HomeScreenViewModel: HomeScreenViewOutput {
    weak var view: HomeScreenViewInput?

    func didChangeSearchText(_ text: String) {
        // Логика поиска
    }
}
