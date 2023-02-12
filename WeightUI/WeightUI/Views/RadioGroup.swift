import UIKit

public struct RadioOptionModel {
    let title: String
    let subtitle: String
    let value: String
    
    public init(title: String, subtitle: String, value: String) {
        self.title = title
        self.subtitle = subtitle
        self.value = value
    }
}

public class RadioGroup: UIControl {
    public required init(models: [RadioOptionModel]) {
        self.models = models
        super.init(frame: .zero)
        setup()
        resetModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var models: [RadioOptionModel] {
        didSet {
            resetModels()
        }
    }

    public var selectedIndex: Int = -1 {
        didSet {
            item(at: oldValue)?.radioButton.isSelected = false
            item(at: selectedIndex)?.radioButton.isSelected = true
        }
    }

    public dynamic var selectedColor: UIColor? {
        didSet {
            forEachItem { $0.radioButton.selectedColor = selectedColor }
        }
    }

    public dynamic var buttonSize: CGFloat = 20 {
        didSet {
            forEachItem { $0.radioButton.size = buttonSize }
        }
    }

    public dynamic var spacing: CGFloat = 8 {
        didSet {
            stackView.spacing = spacing
        }
    }

    public dynamic var itemSpacing: CGFloat = 4 {
        didSet {
            forEachItem { $0.stackView.spacing = itemSpacing }
        }
    }

    public dynamic var isButtonAfterTitle: Bool = false {
        didSet {
            let direction: UISemanticContentAttribute = isButtonAfterTitle ? .forceRightToLeft : .unspecified
            forEachItem { $0.stackView.semanticContentAttribute = direction }
        }
    }

    public dynamic var titleColor: UIColor? {
        didSet {
            guard titleColor != oldValue else { return }
            forEachItem { $0.titleLabel.textColor = titleColor }
        }
    }
    
    @objc public dynamic var titleAlignment: NSTextAlignment = .natural {
        didSet {
            forEachItem { $0.titleLabel.textAlignment = titleAlignment }
        }
    }

    @objc public dynamic var titleFont: UIFont? {
        didSet {
            guard titleFont != oldValue else { return }
            let newFont = titleFont ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
            forEachItem { $0.titleLabel.font = newFont }
        }
    }

    public dynamic var subtitleColor: UIColor? {
        didSet {
            guard subtitleColor != oldValue else { return }
            forEachItem { $0.subtitleLabel.textColor = subtitleColor }
        }
    }
    
    @objc public dynamic var subtitleAlignment: NSTextAlignment = .natural {
        didSet {
            forEachItem { $0.subtitleLabel.textAlignment = titleAlignment }
        }
    }

    @objc public dynamic var subtitleFont: UIFont? {
        didSet {
            guard subtitleFont != oldValue else { return }
            let newFont = subtitleFont ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
            forEachItem { $0.subtitleLabel.font = newFont }
        }
    }

    // MARK: - Private
    private let stackView: UIStackView = {
        let stack = UIStackView().forAutoLayout()
        stack.axis = .vertical
        return stack
    }()
    private var items: [RadioGroupItem] {
        return stackView.arrangedSubviews.compactMap { $0 as? RadioGroupItem }
    }

    private func setup() {
        addSubview(stackView)
        stackView.constrainToSuperview()
        stackView.distribution = .equalSpacing
        setContentCompressionResistancePriority(.required, for: .vertical)
        spacing = { spacing }()
        accessibilityIdentifier = "RadioGroup"
    }

    private func updateAllItems() {
        selectedColor = { selectedColor }()
        buttonSize = { buttonSize }()
        itemSpacing = { itemSpacing }()
        isButtonAfterTitle = { isButtonAfterTitle }()
        titleAlignment = { titleAlignment }()
        selectedIndex = { selectedIndex }()
    }
    
    private func resetModels() {
        stackView.subviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        stackView.addArrangedSubviews(models.map({ RadioGroupItem(title: $0.title, subtitle: $0.subtitle, group: self) }))
        updateAllItems()
    }

    private func item(at index: Int) -> RadioGroupItem? {
        guard index >= 0 && index < stackView.arrangedSubviews.count else { return nil }
        return stackView.arrangedSubviews[index] as? RadioGroupItem
    }

    private func forEachItem(_ perform: (RadioGroupItem) -> Void) {
        items.forEach(perform)
    }

    func selectIndex(item: RadioGroupItem) {
        guard let index = stackView.arrangedSubviews.firstIndex(of: item) else { return }
        selectedIndex = index
        sendActions(for: [.valueChanged, .primaryActionTriggered])
    }

    public override var intrinsicContentSize: CGSize {
        var size = stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width += layoutMargins.left + layoutMargins.right
        size.height += layoutMargins.top + layoutMargins.bottom
        return size
    }
}

class RadioGroupItem: UIView {
    let titleLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    let subtitleLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    let titleStackView: UIStackView = {
        let stack = UIStackView().forAutoLayout()
        stack.axis = .vertical
        stack.spacing = 0
        return stack
    }()
    let radioButton = RadioButton().forAutoLayout()
    let stackView: UIStackView = {
        let stack = UIStackView().forAutoLayout()
        stack.alignment = .center
        return stack
    }()

    unowned var group: RadioGroup

    init(title: String?, subtitle: String?, group: RadioGroup) {
        self.group = group
        super.init(frame: .zero)
        titleLabel.text = title
        subtitleLabel.text = subtitle
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        if let titleFont = group.titleFont {
            titleLabel.font = titleFont
        }
        if let titleColor = group.titleColor {
            titleLabel.textColor = titleColor
        }
        if let subtitleFont = group.subtitleFont {
            subtitleLabel.font = subtitleFont
        }
        if let subtitleColor = group.subtitleColor {
            subtitleLabel.textColor = subtitleColor
        }
        titleStackView.addArrangedSubviews([titleLabel, subtitleLabel])

        addSubview(stackView)
        stackView.constrainToSuperview()
        stackView.addArrangedSubviews([titleStackView, radioButton])
        setContentCompressionResistancePriority(.required, for: .vertical)

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelect)))

        isAccessibilityElement = true
        accessibilityLabel = "option"
        accessibilityValue = titleLabel.text
        accessibilityIdentifier = "RadioGroupItem"
    }

    @objc func didSelect() {
        group.selectIndex(item: self)
    }

    override var accessibilityTraits: UIAccessibilityTraits {
        get {
            return radioButton.isSelected ? [.selected] : []
        }
        set {} // swiftlint:disable:this unused_setter_value
    }
}

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        for subview in subviews {
            addArrangedSubview(subview)
        }
    }
}
