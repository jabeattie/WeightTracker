import UIKit
import Combine

class ViewController: UIViewController {
    
    private let viewModel: ViewModel
    private var eventCancellable: AnyCancellable?
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        button.tintColor = .blue
        return button
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        button.tintColor = .blue
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        listenForEvents()
        // Do any additional setup after loading the view.
        view.addSubview(loginButton)
        view.addSubview(logoutButton)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
    }

    @objc private func loginButtonPressed() {
        let viewController = OnboardingPageViewController(viewModel: OnboardingPageViewModel())
        self.present(viewController, animated: true, completion: nil)
//        viewModel.login()
    }

    @objc private func logoutButtonPressed() {
        viewModel.logout()
    }
    
    private func listenForEvents() {
        eventCancellable = viewModel.publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { [weak self] (event) in
                switch event {
                case .openSignup(let viewModel):
                    let viewController = SignupViewController(viewModel: viewModel)
                    self?.present(viewController, animated: true, completion: nil)
                }
        }
    }
}

