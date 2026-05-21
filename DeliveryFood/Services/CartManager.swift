import Foundation

extension Notification.Name {
    static let cartUpdated = Notification.Name("cartUpdated")
}

final class CartManager {
    static let shared = CartManager()
    private let cartKey = "cart_items"
    private(set) var items: [OrderDishModel] = []

    private init() { loadCart() }

    // MARK: - Public API

    func addDish(_ dish: OrderDishModel) {
        if let index = items.firstIndex(where: { $0.id == dish.id }) {
            var existing = items[index]
            existing.quantity += dish.quantity
            items[index] = existing
        } else {
            items.append(dish)
        }
        saveCart()
        notifyUpdate()
    }

    func updateQuantity(for dishID: String, quantity: Int) {
        guard let index = items.firstIndex(where: { $0.id == dishID }) else { return }
        if quantity <= 0 {
            items.remove(at: index)
        } else {
            var existing = items[index]
            existing.quantity = quantity
            items[index] = existing
        }
        saveCart()
        notifyUpdate()
    }

    func updateLikeStatus(for dishID: String, isLiked: Bool, isDisliked: Bool) {
        guard let index = items.firstIndex(where: { $0.id == dishID }) else { return }
        var existing = items[index]
        existing.isLiked = isLiked
        existing.isDisliked = isDisliked
        items[index] = existing
        saveCart()
        notifyUpdate()
    }

    func remove(item: OrderDishModel) {
        items.removeAll { $0.id == item.id }
        saveCart()
        notifyUpdate()
    }

    func clearCart() {
        items.removeAll()
        saveCart()
        notifyUpdate()
    }

    // MARK: - Persistence

    private func saveCart() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: cartKey)
        }
    }

    private func loadCart() {
        guard let data = UserDefaults.standard.data(forKey: cartKey),
              let decoded = try? JSONDecoder().decode([OrderDishModel].self, from: data) else { return }
        items = decoded
    }

    private func notifyUpdate() {
        let post = { NotificationCenter.default.post(name: .cartUpdated, object: nil) }
        Thread.isMainThread ? post() : DispatchQueue.main.async(execute: post)
    }
}
