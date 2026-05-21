import UIKit

struct DishCellModel {
    let id: String
    let title: String
    let imageName: UIImage
    let price: String
    var isLiked: Bool = false
    var isDisliked: Bool = false
}
