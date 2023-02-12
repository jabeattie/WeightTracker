import UIKit

final class SignupView: UIView {
    private lazy var scroll: UIScrollView = {
        let scroll = UIScrollView().forAutoLayout()
        return scroll
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [email, height]).forAutoLayout()
        stack.axis = .vertical
        stack.spacing = 32
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 32, left: 16, bottom: 32, right: 16)
        return stack
    }()
    
    private lazy var email: UILabel = {
        let label = UILabel().forAutoLayout()
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    
    private lazy var height: UITextField = {
        let field = UITextField().forAutoLayout()
        field.placeholder = "170"
        field.textColor = .white
        return field
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: SignupViewProtocol) {
        email.text = viewModel.email
    }
    
    private func setupViewHierarchy() {
        backgroundColor = .purple
        addSubview(scroll)
        scroll.addSubview(stack)
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: topAnchor),
            scroll.leadingAnchor.constraint(equalTo: leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: bottomAnchor),
        
            stack.topAnchor.constraint(equalTo: scroll.topAnchor),
            stack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            stack.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
}

