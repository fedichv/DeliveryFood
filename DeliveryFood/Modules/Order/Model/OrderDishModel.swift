import UIKit

struct OrderDishModel: Codable {
    let id: String
    let name: String
    let price: Double
    var quantity: Int
    var imageData: Data?
    var likes: Int
    var dislikes: Int
    var isLiked: Bool
    var isDisliked: Bool

    var image: UIImage? {
        get { imageData.flatMap { UIImage(data: $0) } }
        set { imageData = newValue?.jpegData(compressionQuality: 0.9) }
    }
}
