import Foundation
import API
import Combine
import Auth0
import Core

protocol SignupViewProtocol {
    var email: String { get }
    var height: String { get }
}

class SignupViewModel {
    private let router: Router<AccountEndpoint>
    private var publisher: AnyPublisher<User, Error>?
    private let profile: Profile
    private let credentials: Credentials
    
    init(profile: Profile,
         credentials: Credentials,
         router: Router<AccountEndpoint> = Router<AccountEndpoint>()) {
        self.profile = profile
        self.credentials = credentials
        self.router = router
    }
    
    
    func signup() {
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
//                    self.store(credentials: credentials, profile: profile)
                    self.signupOnServer(token: accessToken, email: profile.email!)
//                    self.loginOnServer(token: accessToken)
                case .failure(error: let error):
                    print(error)
                }
        }
    }
    
//    private func store(credentials: Credentials, profile: Profile) {
//        print("access token: \(credentials.accessToken ?? "")")
//        print("id token: \(credentials.idToken ?? "")")
//        _ = credentialsManager.store(credentials: credentials)
//    }
    
    var anyCancellable: AnyCancellable?
    
    func loginOnServer(token: String) {
        publisher = router.request(.get(bearerToken: token))
        anyCancellable = publisher?.sink(receiveCompletion: { (completion) in
            print(completion)
        }, receiveValue: { (user) in
            print(user)
        })
    }
    
    func signupOnServer(token: String, email: String) {
//        let user = User(id: nil, email: email, gender: .male, dob:"1989-01-03", heightUnit: .cm, weightUnit: .kg, height: 180)
//        guard let dict = try? user.asDictionary() else { return }
//        publisher = router.request(.create(dict))
//        anyCancellable = publisher?.sink(receiveCompletion: { (completion) in
//            print(completion)
//        }, receiveValue: { (user) in
//            print(user)
//        })
    }
}

extension SignupViewModel: SignupViewProtocol {
    var email: String {
        return profile.email ?? ""
    }
    
    var height: String { return "" }
}
