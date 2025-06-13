//
//  AuthViewModel.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 4/21/25.
//

import UIKit


struct ServerResponse: Codable {
    let success: Bool
    let message: String
}

class AuthViewModel: AuthViewOutput {
    weak var view: AuthViewInput?
    private let coordinator: AuthCoordinator
    
    init(view: AuthViewInput, coordinator: AuthCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func didChangeSearchText(_ text: String) {
        
    }
    
    func didTapAuthButton(with credentials: AuthCredentials, mode: AuthMode) {
        guard credentials.isValid(for: mode) else {
            print("❌ Invalid credentials")
            return
        }
        
        let url = URL(string:"http://127.0.0.1:8844/auth")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = [
            "command": mode == .signUp ? "signup" : "signin",
            "username": credentials.username,
            "password": credentials.password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            print("failed to serialize JSON")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("❌Network Error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("❌No data received")
                    return
                }
                
                do {
                    let serverResponse = try JSONDecoder().decode(ServerResponse.self, from: data)
                    print("📩 Server response:", serverResponse)

                    if serverResponse.success {
                        print("✅", serverResponse.message)
                        print("🚀 Coordinator переход на экран: \(mode == .signIn ? "main" : "signIn")")

                        switch mode {
                        case .signIn:
                            self.coordinator.open(screen: .home)
                        case .signUp:
                            self.coordinator.open(screen: .signIn)
                        }
                    } else {
                        print("❌ Server error:", serverResponse.message)
                    }
                } catch {
                    print("❌ Failed to decode server response:", error)
                    print("📩 Raw data:", String(data: data, encoding: .utf8) ?? "nil")
                }
            }
        }
        task.resume()
    }
    func goTo(screen: AuthCoordinator.AuthCoordinatorScreen) {
        coordinator.open(screen: screen)
    }
}

