import Foundation

class OnboardingPageViewModel {
    let pages: [OnboardingPageModel]
    var currentIndex: Int = 0
    
    init() {
        pages = OnboardingPageModel.Page.allCases.map(OnboardingPageModel.init)
    }
}

struct OnboardingPageModel {
    enum Page: CaseIterable {
        case weightEntry
        case heightEntry
        case bmiEntry
        case bmrEntry
        
        var title: String {
            switch self {
            case .weightEntry:
                return "weightEntry"
            case .heightEntry:
                return "heightEntry"
            case .bmiEntry:
                return "bmiEntry"
            case .bmrEntry:
                return "bmrEntry"
            }
        }
        
        var index: Int {
            switch self {
            case .weightEntry:
                return 0
            case .heightEntry:
                return 1
            case .bmiEntry:
                return 2
            case .bmrEntry:
                return 3
            }
        }
    }
    
    let page: Page
}
