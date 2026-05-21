import UIKit

enum UserDefaultsKeys: String {
    case isLoggedIn
    case loginDate
}

struct ServerResponse: Codable {
    let success: Bool
    let message: String
}

final class AuthViewModel: AuthViewOutput {
    weak var view: AuthViewInput?
    private let coordinator: AuthCoordinator

    init(view: AuthViewInput, coordinator: AuthCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }

    func didChangeSearchText(_ text: String) {}

    func didTapAuthButton(with credentials: AuthCredentials, mode: AuthMode) {
        guard credentials.isValid(for: mode) else {
            print("❌ Invalid credentials")
            return
        }

        let url = URL(string: "http://127.0.0.1:8844/auth")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = [
            "command": mode == .signUp ? "signup" : "signin",
            "username": credentials.username,
            "password": credentials.password
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            print("Failed to serialize JSON")
            return
        }

        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("❌ Network error: \(error.localizedDescription)")
                    return
                }
                guard let data = data else { print("❌ No data"); return }

                do {
                    let response = try JSONDecoder().decode(ServerResponse.self, from: data)
                    if response.success {
                        switch mode {
                        case .signIn:
                            UserDefaultsManager.shared.set(true, forKey: .isLoggedIn)
                            UserDefaults.standard.set(Date(), forKey: UserDefaultsKeys.loginDate.rawValue)
                            self?.coordinator.open(screen: .home)
                        case .signUp:
                            self?.coordinator.open(screen: .signIn)
                        }
                    } else {
                        print("❌ Server error: \(response.message)")
                    }
                } catch {
                    print("❌ Decode error: \(error)")
                }
            }
        }.resume()
    }

    func goTo(screen: AuthCoordinator.AuthCoordinatorScreen) {
        coordinator.open(screen: screen)
    }

    func checkIfUserIsLoggedIn() {
        if let lastLogin = UserDefaults.standard.object(forKey: UserDefaultsKeys.loginDate.rawValue) as? Date {
            let days = Calendar.current.dateComponents([.day], from: lastLogin, to: Date()).day ?? 0
            if days >= 7 {
                UserDefaultsManager.shared.set(false, forKey: .isLoggedIn)
                UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.loginDate.rawValue)
            }
        }
        if UserDefaultsManager.shared.getBool(forKey: .isLoggedIn) {
            coordinator.open(screen: .home)
        }
    }
}
