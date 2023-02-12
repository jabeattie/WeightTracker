import UIKit
import WeightUI

struct OnboardingEntryViewModel {
    let page: OnboardingPageModel
}

class OnboardingEntryViewController: UIViewController {
    
    var page: OnboardingPageModel.Page { viewModel.page.page }
    
    private let viewModel: OnboardingEntryViewModel
    
    init(viewModel: OnboardingEntryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Asset.Colours.deepPurple700.color
        let innerView: UIView
        switch page {
        case .weightEntry:
            innerView = WeightEntryView().forAutoLayout()
        case .heightEntry:
            innerView = HeightEntryView().forAutoLayout()
        case .bmiEntry:
            innerView = BMIEntryView().forAutoLayout()
        case .bmrEntry:
            innerView = BMREntryView().forAutoLayout()
        }
        view.addSubview(innerView)
        innerView.constrainToSuperview()
    }
    
}
