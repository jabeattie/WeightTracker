import UIKit
import WeightUI

class OnboardingPageViewController: UIViewController {
    
    private let viewModel: OnboardingPageViewModel
    
    private lazy var pageController: UIPageViewController = {
        let controller = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        controller.dataSource = self
        controller.delegate = self
        controller.view.backgroundColor = .clear
        return controller
    }()
    
    init(viewModel: OnboardingPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Asset.Colours.deepPurple900.color
        setupView()
    }
    
    private func setupView() {
        addChild(pageController)
        view.addSubview(pageController.view)
        let initialVC = OnboardingEntryViewController(viewModel: OnboardingEntryViewModel(page: viewModel.pages[0]))
        pageController.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        pageController.didMove(toParent: self)
    }
}

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    
}

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewModel.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return viewModel.currentIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingEntryViewController else { return nil }
        
        var index = currentVC.page.index
        
        if index == 0 {
            return nil
        }
        index -= 1
        
        let viewController = OnboardingEntryViewController(viewModel: OnboardingEntryViewModel(page: viewModel.pages[index]))
        
        return viewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingEntryViewController else { return nil }
        
        var index = currentVC.page.index
        
        if index >= viewModel.pages.count - 1 {
            return nil
        }
        index += 1
        
        let viewController = OnboardingEntryViewController(viewModel: OnboardingEntryViewModel(page: viewModel.pages[index]))
        
        return viewController
    }
}
