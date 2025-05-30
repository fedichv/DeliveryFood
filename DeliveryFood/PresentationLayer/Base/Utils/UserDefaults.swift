//
//  Untitled.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 4/25/25.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    enum Key: String {
        case username
        case isWatchedOnboarding
        case isLoggedIn
//        case launchCount
    }
    
    // MARK: - Строки
    func set(_ value: String, forKey key: Key) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    func getString(forKey key: Key) -> String? {
        return defaults.string(forKey: key.rawValue)
    }
    
    // MARK: - Булевы значения
    func set(_ value: Bool, forKey key: Key) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    func getBool(forKey key: Key) -> Bool {
        return defaults.bool(forKey: key.rawValue)
    }
    
    // MARK: - Int
    func set(_ value: Int, forKey key: Key) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    func getInt(forKey key: Key) -> Int {
        return defaults.integer(forKey: key.rawValue)
    }
    
    // MARK: - Удаление значения
    func removeValue(forKey key: Key) {
        defaults.removeObject(forKey: key.rawValue)
    }
    
    // MARK: - Очистка всех данных (в пределах этого контейнера)
    func clearAll() {
        for key in Key.allCases {
            defaults.removeObject(forKey: key.rawValue)
        }
    }
}

// Расширение для получения всех кейсов enum
extension UserDefaultsManager.Key: CaseIterable {}
