import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIView {
    func superview<T: UIView>(of type: T.Type) -> T? {
        return superview as? T ?? superview?.superview(of: T.self)
    }
}
