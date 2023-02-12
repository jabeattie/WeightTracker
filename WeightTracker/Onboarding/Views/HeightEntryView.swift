import UIKit
import WeightUI

class HeightEntryView: UIView {
    
    private lazy var wrapperStack: UIStackView = {
        let stack = UIStackView().forAutoLayout()
        stack.axis = .horizontal
        stack.alignment = .top
        return stack
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView().forAutoLayout()
        stack.axis = .vertical
        stack.spacing = Dimension.extraLarge
        return stack
    }()
    
    private lazy var heightOptionStack: UIStackView = {
        let stack = UIStackView().forAutoLayout()
        stack.axis = .vertical
        stack.spacing = Dimension.medium
        return stack
    }()
    
    private lazy var heightEntryStack: UIStackView = {
        let stack = UIStackView().forAutoLayout()
        stack.axis = .vertical
        stack.spacing = Dimension.medium
        stack.alignment = .center
        return stack
    }()
    
    private lazy var heightOptionTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = Asset.Colours.deepPurple100.color
        label.font = FontFamily.ProximaNova.regular.font(size: 24)
        label.text = "How would you like to enter your height?"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var heightOption: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["CM", "Feet"])
        segmentedControl.selectedSegmentTintColor = Asset.Colours.deepPurple100.color
        segmentedControl.setTitleTextAttributes([.foregroundColor: Asset.Colours.deepPurple100.color, .font: FontFamily.ProximaNova.regular.font(size: 18)], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: Asset.Colours.deepPurple700.color, .font: FontFamily.ProximaNova.regular.font(size: 18)], for: .selected)
        segmentedControl.heightAnchor.constraint(equalToConstant: 50).activated()
        return segmentedControl
    }()
    
    private lazy var heightTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = Asset.Colours.deepPurple100.color
        label.font = FontFamily.ProximaNova.regular.font(size: 24)
        label.text = "What is your current height?"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var heightEntryFancy: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colours.deepPurple100.color
        view.heightAnchor.constraint(equalToConstant: 200).activated()
        view.widthAnchor.constraint(equalToConstant: 100).activated()
        return view
    }()
    
    private lazy var heightTextField: UnderlinedTextfield = {
        let textField = UnderlinedTextfield()
        textField.textColor = Asset.Colours.deepPurple100.color
        textField.font = FontFamily.ProximaNova.regular.font(size: 24)
        textField.attributedPlaceholder = NSAttributedString(string: "170 cm", attributes: [.foregroundColor: Asset.Colours.deepPurple400.color])
        textField.textAlignment = .center
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(wrapperStack)
        
        wrapperStack.addArrangedSubview(stack)
        
        stack.addArrangedSubview(heightOptionStack)
        heightOptionStack.addArrangedSubview(heightOptionTitle)
        heightOptionStack.addArrangedSubview(heightOption)
        
        stack.addArrangedSubview(heightEntryStack)
        heightEntryStack.addArrangedSubview(heightTitle)
        heightEntryStack.addArrangedSubview(heightEntryFancy)
        heightEntryStack.addArrangedSubview(heightTextField)
        
        wrapperStack.constrainToSuperview(insets: UIEdgeInsets(all: Dimension.large))
    }

}
