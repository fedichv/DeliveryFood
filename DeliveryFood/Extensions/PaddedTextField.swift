import UIKit

final class PaddedTextField: UITextField {
    var textInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    override func textRect(forBounds bounds: CGRect) -> CGRect        { bounds.inset(by: textInsets) }
    override func editingRect(forBounds bounds: CGRect) -> CGRect     { bounds.inset(by: textInsets) }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect { bounds.inset(by: textInsets) }
}
