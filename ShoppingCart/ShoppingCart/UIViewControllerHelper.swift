import UIKit

extension UIViewController {
    // MARK: - Configure tap gesture
    func configureTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(resignFirstResponderTextField))
        self.view.addGestureRecognizer(tap)
    }
    
    // MARK: - Resign first responder of text field
    func resignFirstResponderTextField() {
    }
}
