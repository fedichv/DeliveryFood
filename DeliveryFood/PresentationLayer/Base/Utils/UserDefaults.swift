import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    enum Key: String, CaseIterable {
        case username
        case isWatchedOnboarding
        case isLoggedIn
        case likedDishes       // Словарь [dishID: [isLiked: Bool, isDisliked: Bool]]
        case orderCounts       // Словарь [dishID: Int]
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
    
    // MARK: - Лайки и дизлайки по dishID
    
    func setLikedStatus(isLiked: Bool, isDisliked: Bool, forDishID dishID: String) {
        var statusDict = defaults.dictionary(forKey: Key.likedDishes.rawValue) as? [String: [String: Bool]] ?? [:]
        statusDict[dishID] = ["isLiked": isLiked, "isDisliked": isDisliked]
        defaults.set(statusDict, forKey: Key.likedDishes.rawValue)
    }

    func getLikedStatus(forDishID dishID: String) -> (isLiked: Bool, isDisliked: Bool) {
        let statusDict = defaults.dictionary(forKey: Key.likedDishes.rawValue) as? [String: [String: Bool]] ?? [:]
        let status = statusDict[dishID] ?? [:]
        return (status["isLiked"] ?? false, status["isDisliked"] ?? false)
    }
    
    // MARK: - Количество заказов по dishID
    
    /// Сохраняет количество заказа блюда по уникальному dishID
    func setOrderCount(_ count: Int, forDishID dishID: String) {
        var counts = defaults.dictionary(forKey: Key.orderCounts.rawValue) as? [String: Int] ?? [:]
        counts[dishID] = count
        defaults.set(counts, forKey: Key.orderCounts.rawValue)
    }
    
    /// Получает количество заказа блюда по уникальному dishID
    func getOrderCount(forDishID dishID: String) -> Int {
        let counts = defaults.dictionary(forKey: Key.orderCounts.rawValue) as? [String: Int] ?? [:]
        return counts[dishID] ?? 0
    }
}
