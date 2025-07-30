import UIKit

final class CartManager {
    static let shared = CartManager()
    
    private let cartKey = "cart_items" // ключ в UserDefaults
    
    private(set) var items: [OrderDishModel] = []
    
    private init() {
        loadCart() // загружаем корзину при запуске
    }
    
    // MARK: - Добавляем блюдо
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
    
    // MARK: - Обновляем количество
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
    
    // MARK: - Обновляем лайки
    func updateLikeStatus(for dishID: String, isLiked: Bool, isDisliked: Bool) {
        guard let index = items.firstIndex(where: { $0.id == dishID }) else { return }
        var existing = items[index]
        existing.isLiked = isLiked
        existing.isDisliked = isDisliked
        items[index] = existing
        saveCart()
        notifyUpdate()
    }
    
    // MARK: - Очистка корзины
    func clearCart() {
        items.removeAll()
        saveCart()
        notifyUpdate()
    }
    
    // MARK: - Сохранение и загрузка из UserDefaults
    
    private func saveCart() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: cartKey)
        }
    }
    
    private func loadCart() {
        if let savedData = UserDefaults.standard.data(forKey: cartKey) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([OrderDishModel].self, from: savedData) {
                self.items = decoded
            }
        }
    }
    
    // MARK: - Обновление UI
    private func notifyUpdate() {
        if Thread.isMainThread {
            NotificationCenter.default.post(name: .cartUpdated, object: nil)
        } else {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .cartUpdated, object: nil)
            }
        }
    }
}

extension Notification.Name {
    static let cartUpdated = Notification.Name("cartUpdated")
}
