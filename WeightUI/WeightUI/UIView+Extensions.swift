import UIKit

public extension UIView {
    @discardableResult
    func constrainToSuperview(insets: UIEdgeInsets = .zero, activated: Bool = true) -> [NSLayoutConstraint] {
        guard let superview = superview else {
            fatalError("View has no superview")
        }
        let constraints = [
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.right),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom)
        ]
        if activated {
            NSLayoutConstraint.activate(constraints)
        }
        return constraints
    }
    
    @discardableResult
    func constrainToSuperviewMargins(insets: UIEdgeInsets = .zero, activated: Bool = true) -> [NSLayoutConstraint] {
        guard let superview = superview else {
            fatalError("View has no superview")
        }
        let constraints = [
            topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor, constant: insets.right),
            trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: -insets.bottom)
        ]
        if activated {
            NSLayoutConstraint.activate(constraints)
        }
        return constraints
    }
    
    func addConstraintWithoutConflict(_ constraint: NSLayoutConstraint) {
        removeConstraints(constraints.filter {
            constraint.firstItem === $0.firstItem
                && constraint.secondItem === $0.secondItem
                && constraint.firstAttribute == $0.firstAttribute
                && constraint.secondAttribute == $0.secondAttribute
        })
        addConstraint(constraint)
    }
    
    func forAutoLayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    var actualTintColor: UIColor {
        var tintedView: UIView? = self
        while let currentView = tintedView, nil == currentView.tintColor {
            tintedView = currentView.superview
        }
        return tintedView?.tintColor ?? UIColor(red: 0, green: 0.5, blue: 1, alpha: 1)
    }
}
