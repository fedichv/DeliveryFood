import UIKit

final class AuthFactory {
    static func makeAuthViewController(mode: AuthMode, coordinator: AuthCoordinator) -> AuthViewController {
        let vc = AuthViewController(authMode: mode)
        let vm = AuthViewModel(view: vc, coordinator: coordinator)
        vc.output = vm
        return vc
    }
}
