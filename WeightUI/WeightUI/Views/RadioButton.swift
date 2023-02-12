import UIKit

public class RadioButton: UIView {
    public var isSelected: Bool = false {
        didSet {
            selectedCenterView.isHidden = !isSelected
            if isSelected {
                accessibilityTraits.insert(.selected)
            } else {
                accessibilityTraits.remove(.selected)
            }
        }
    }

    public dynamic var size: CGFloat = 20 {
        didSet {
            addConstraintWithoutConflict(heightAnchor.constraint(equalToConstant: size))
            layer.cornerRadius = size / 2
            updateCenterRadius()
            invalidateIntrinsicContentSize()
        }
    }

    public dynamic var ringWidth: CGFloat = 2 {
        didSet {
            layer.borderWidth = ringWidth
        }
    }

    public dynamic var ringSpacing: CGFloat = 4 {
        didSet {
            layoutMargins = UIEdgeInsets(top: ringSpacing, left: ringSpacing, bottom: ringSpacing, right: ringSpacing)
            updateCenterRadius()
        }
    }

    public dynamic var selectedColor: UIColor? {
        didSet {
            selectedCenterView.backgroundColor = selectedColor
        }
    }

    private let selectedCenterView = UIView().forAutoLayout()

    private func setup() {
        widthAnchor.constraint(equalTo: heightAnchor).activated()
        setContentHuggingPriority(.required, for: .vertical)
        setContentHuggingPriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .vertical)
        setContentCompressionResistancePriority(.required, for: .horizontal)
        addSubview(selectedCenterView)
        selectedCenterView.constrainToSuperviewMargins()
        selectedCenterView.layoutMargins = .zero
        selectedColor = { selectedColor }()
        size = { size }()
        ringWidth = { ringWidth }()
        ringSpacing = { ringSpacing }()
        isSelected = { isSelected }()
        tintColorDidChange()
        isAccessibilityElement = true
        accessibilityLabel = "radio button"
        accessibilityTraits = [.button]
        accessibilityIdentifier = "RadioButton"
    }

    private func updateCenterRadius() {
        selectedCenterView.layer.cornerRadius = (size - layoutMargins.bottom - layoutMargins.top) / 2
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    open override func tintColorDidChange() {
        super.tintColorDidChange()
        let newTint = actualTintColor
        layer.borderColor = newTint.cgColor
        if nil == selectedColor {
            selectedCenterView.backgroundColor = newTint
        }
    }

    open override var intrinsicContentSize: CGSize {
        return CGSize(width: size, height: size)
    }
}
