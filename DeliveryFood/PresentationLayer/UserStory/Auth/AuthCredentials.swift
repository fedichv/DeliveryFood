//
//  AuthCredentials.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 6/5/25.
//

import Foundation

struct AuthCredentials: Codable {
    let username: String
    let password: String
    let reenterPassword: String?
    
    func isValid(for mode: AuthMode) -> Bool{
        guard !username.isEmpty, !password.isEmpty else { return false }
        if mode == .signUp {
            return password == reenterPassword
        }
        return true
    }
}
