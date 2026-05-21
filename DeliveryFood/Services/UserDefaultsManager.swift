import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    private init() {}

    enum Key: String, CaseIterable {
        case username
        case isWatchedOnboarding
        case isLoggedIn
        case likedDishes
        case orderCounts
    }

    // MARK: - String

    func set(_ value: String, forKey key: Key) { defaults.set(value, forKey: key.rawValue) }
    func getString(forKey key: Key) -> String? { defaults.string(forKey: key.rawValue) }

    // MARK: - Bool

    func set(_ value: Bool, forKey key: Key) { defaults.set(value, forKey: key.rawValue) }
    func getBool(forKey key: Key) -> Bool { defaults.bool(forKey: key.rawValue) }

    // MARK: - Int

    func set(_ value: Int, forKey key: Key) { defaults.set(value, forKey: key.rawValue) }
    func getInt(forKey key: Key) -> Int { defaults.integer(forKey: key.rawValue) }

    // MARK: - Cleanup

    func removeValue(forKey key: Key) { defaults.removeObject(forKey: key.rawValue) }
    func clearAll() { Key.allCases.forEach { defaults.removeObject(forKey: $0.rawValue) } }

    // MARK: - Likes

    func setLikedStatus(isLiked: Bool, isDisliked: Bool, forDishID dishID: String) {
        var dict = defaults.dictionary(forKey: Key.likedDishes.rawValue) as? [String: [String: Bool]] ?? [:]
        dict[dishID] = ["isLiked": isLiked, "isDisliked": isDisliked]
        defaults.set(dict, forKey: Key.likedDishes.rawValue)
    }

    func getLikedStatus(forDishID dishID: String) -> (isLiked: Bool, isDisliked: Bool) {
        let dict = defaults.dictionary(forKey: Key.likedDishes.rawValue) as? [String: [String: Bool]] ?? [:]
        let entry = dict[dishID] ?? [:]
        return (entry["isLiked"] ?? false, entry["isDisliked"] ?? false)
    }

    // MARK: - Order counts

    func setOrderCount(_ count: Int, forDishID dishID: String) {
        var counts = defaults.dictionary(forKey: Key.orderCounts.rawValue) as? [String: Int] ?? [:]
        counts[dishID] = count
        defaults.set(counts, forKey: Key.orderCounts.rawValue)
    }

    func getOrderCount(forDishID dishID: String) -> Int {
        let counts = defaults.dictionary(forKey: Key.orderCounts.rawValue) as? [String: Int] ?? [:]
        return counts[dishID] ?? 0
    }
}
