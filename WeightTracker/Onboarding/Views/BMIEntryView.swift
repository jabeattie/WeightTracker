import UIKit
import WeightUI

class BMIEntryView: UIView {
    
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
    
    private lazy var dateOfBirthStack: UIStackView = {
        let stack = UIStackView().forAutoLayout()
        stack.axis = .vertical
        stack.spacing = Dimension.medium
        return stack
    }()
    
    private lazy var sexStack: UIStackView = {
        let stack = UIStackView().forAutoLayout()
        stack.axis = .vertical
        stack.spacing = Dimension.medium
        stack.alignment = .center
        return stack
    }()
    
    private lazy var dateOfBirthTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = Asset.Colours.deepPurple100.color
        label.font = FontFamily.ProximaNova.regular.font(size: 24)
        label.text = "How would you like to enter your height?"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dateOfBirthTextField: UnderlinedTextfield = {
        let textField = UnderlinedTextfield()
        textField.textColor = Asset.Colours.deepPurple100.color
        textField.font = FontFamily.ProximaNova.regular.font(size: 24)
        textField.attributedPlaceholder = NSAttributedString(string: "31/12/1990", attributes: [.foregroundColor: Asset.Colours.deepPurple400.color])
        textField.textAlignment = .center
        return textField
    }()
    
    private lazy var sexTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = Asset.Colours.deepPurple100.color
        label.font = FontFamily.ProximaNova.regular.font(size: 24)
        label.text = "What is your sex?"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var sexOption: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Male", "Female"])
        segmentedControl.selectedSegmentTintColor = Asset.Colours.deepPurple100.color
        segmentedControl.setTitleTextAttributes([.foregroundColor: Asset.Colours.deepPurple100.color, .font: FontFamily.ProximaNova.regular.font(size: 18)], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: Asset.Colours.deepPurple700.color, .font: FontFamily.ProximaNova.regular.font(size: 18)], for: .selected)
        segmentedControl.heightAnchor.constraint(equalToConstant: 50).activated()
        return segmentedControl
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
        
        stack.addArrangedSubview(dateOfBirthStack)
        dateOfBirthStack.addArrangedSubview(dateOfBirthTitle)
        dateOfBirthStack.addArrangedSubview(dateOfBirthTextField)
        
        stack.addArrangedSubview(sexStack)
        sexStack.addArrangedSubview(sexTitle)
        sexStack.addArrangedSubview(sexOption)
        
        wrapperStack.constrainToSuperview(insets: UIEdgeInsets(all: Dimension.large))
    }

}
