import UIKit
import Core
import WeightUI

struct WeightEntry {
    let weightUnit: WeightUnit = .kg
    let weight: LocalWeight?
    
    var isComplete: Bool {
        return weight != nil
    }
}

class WeightEntryView: UIView {
    
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
    
    private lazy var weightOptionStack: UIStackView = {
        let stack = UIStackView().forAutoLayout()
        stack.axis = .vertical
        stack.spacing = Dimension.medium
        return stack
    }()
    
    private lazy var weightEntryStack: UIStackView = {
        let stack = UIStackView().forAutoLayout()
        stack.axis = .vertical
        stack.spacing = Dimension.medium
        stack.alignment = .center
        return stack
    }()
    
    private lazy var weightOptionTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = Asset.Colours.deepPurple100.color
        label.font = FontFamily.ProximaNova.regular.font(size: 24)
        label.text = "How would you like to enter your weight?"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var weightOption: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: WeightUnit.allCases.map(\.displayValue))
        segmentedControl.selectedSegmentTintColor = Asset.Colours.deepPurple100.color
        segmentedControl.setTitleTextAttributes([.foregroundColor: Asset.Colours.deepPurple100.color, .font: FontFamily.ProximaNova.regular.font(size: 18)], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: Asset.Colours.deepPurple700.color, .font: FontFamily.ProximaNova.regular.font(size: 18)], for: .selected)
        segmentedControl.heightAnchor.constraint(equalToConstant: 50).activated()
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private lazy var weightTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = Asset.Colours.deepPurple100.color
        label.font = FontFamily.ProximaNova.regular.font(size: 24)
        label.text = "What is your current weight?"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var weightEntryFancy: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colours.deepPurple100.color
        view.heightAnchor.constraint(equalToConstant: 100).activated()
        view.widthAnchor.constraint(equalToConstant: 200).activated()
        return view
    }()
    
    private lazy var weightTextField: UnderlinedTextfield = {
        let textField = UnderlinedTextfield()
        textField.textColor = Asset.Colours.deepPurple100.color
        textField.font = FontFamily.ProximaNova.regular.font(size: 24)
        textField.attributedPlaceholder = NSAttributedString(string: "70 kg", attributes: [.foregroundColor: Asset.Colours.deepPurple400.color])
        textField.textAlignment = .center
        return textField
    }()
    
    var model: WeightEntry = WeightEntry(weight: nil)
    
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
        
        stack.addArrangedSubview(weightOptionStack)
        weightOptionStack.addArrangedSubview(weightOptionTitle)
        weightOptionStack.addArrangedSubview(weightOption)
        
        stack.addArrangedSubview(weightEntryStack)
        weightEntryStack.addArrangedSubview(weightTitle)
        weightEntryStack.addArrangedSubview(weightEntryFancy)
        weightEntryStack.addArrangedSubview(weightTextField)
        
        wrapperStack.constrainToSuperview(insets: UIEdgeInsets(all: Dimension.large))
    }

}
