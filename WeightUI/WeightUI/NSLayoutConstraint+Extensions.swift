import UIKit

public extension NSLayoutConstraint {
    @discardableResult
    func activated() -> Self {
        isActive = true
        return self
    }
}
