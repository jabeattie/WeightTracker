import UIKit
import WeightUI
import Core

class BMREntryView: UIView {
    
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
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = Asset.Colours.deepPurple100.color
        label.font = FontFamily.ProximaNova.regular.font(size: 24)
        label.text = "What is your activity level?"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var optionStack: UIStackView = {
        let stack = UIStackView().forAutoLayout()
        stack.axis = .vertical
        stack.spacing = Dimension.medium
        return stack
    }()
    
    private lazy var radioGroup: RadioGroup = {
        let group = RadioGroup(models: models)
        group.tintColor = Asset.Colours.deepPurple100.color
        group.selectedColor = Asset.Colours.deepPurple100.color
        group.buttonSize = Dimension.large
        group.titleColor = .white
        group.titleFont = FontFamily.ProximaNova.regular.font(size: 28)
        group.subtitleColor = Asset.Colours.deepPurple100.color
        group.subtitleFont = FontFamily.ProximaNova.regular.font(size: 14)
        group.spacing = Dimension.large
        return group
    }()
    
    private let models: [RadioOptionModel] = PhysicalActivityProfile.allCases.map(RadioOptionModel.init(physicalActivityProfile:))
    
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
        
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(radioGroup)
        
        wrapperStack.constrainToSuperview(insets: UIEdgeInsets(all: Dimension.large))
    }

}

extension RadioOptionModel {
    init(physicalActivityProfile: PhysicalActivityProfile) {
        self.init(title: physicalActivityProfile.displayName, subtitle: physicalActivityProfile.displaySubtitle, value: physicalActivityProfile.rawValue)
    }
}
