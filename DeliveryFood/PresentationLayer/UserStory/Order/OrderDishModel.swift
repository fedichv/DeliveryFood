//
//  DishOrderModel.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 7/8/25.
//
import UIKit

struct OrderDishModel: Codable {
    let id: String
    let name: String
    let price: Double
    var quantity: Int
    var imageData: Data? // вместо UIImage (UIImage нельзя кодировать)
    var likes: Int
    var dislikes: Int
    var isLiked: Bool
    var isDisliked: Bool
    
    // Свойство для удобного доступа к UIImage
    var image: UIImage? {
        get {
            if let data = imageData { return UIImage(data: data) }
            return nil
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 0.9)
        }
    }
}
