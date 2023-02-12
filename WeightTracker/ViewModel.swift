import Combine
import Foundation
import Auth0

struct ViewModel {
    
    enum Event {
        case openSignup(SignupViewModel)
    }
    
    let publisher: PassthroughSubject<Event, Error>
    private let credentialsManager: CredentialsManager
    
    init(credentialsManager: CredentialsManager = CredentialsManager(authentication: Auth0.authentication())) {
        self.credentialsManager = credentialsManager
        self.publisher = PassthroughSubject()
    }
    
    func login() {
        Auth0
            .webAuth()
            .scope("openid profile email")
            .audience("https://ceramicapps.com/weighttracker")
            .start(self.handle(credentialResult:))
    }
    
    func logout() {
        Auth0
        .webAuth()
        .clearSession(federated:false) {
            switch $0 {
            case true:
                print("Logged out")
            case false:
                print("Couldn't log out")
            }
        }
    }
    
    private func handle(credentialResult: Result<Credentials>) {
        switch credentialResult {
        case .failure(let error):
            // Handle the error
            print("Error: \(error)")
        case .success(let credentials):
            fetchUserInfo(for: credentials)
        }
    }
    
    private func fetchUserInfo(for credentials: Credentials) {
        guard let accessToken = credentials.accessToken else { return }
        Auth0
            .authentication()
            .userInfo(token: accessToken)
            .start { (result) in
                switch result {
                case .success(result: let profile):
                    self.store(credentials: credentials, profile: profile)
                    self.publisher.send(.openSignup(SignupViewModel(profile: profile, credentials: credentials)))
                case .failure(error: let error):
                    print(error)
                }
        }
    }
    
    private func store(credentials: Credentials, profile: Profile) {
        print("access token: \(credentials.accessToken ?? "")")
        print("id token: \(credentials.idToken ?? "")")
        _ = credentialsManager.store(credentials: credentials)
    }
}
