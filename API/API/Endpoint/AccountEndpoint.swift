import Foundation

public enum AccountEndpoint: EndpointType {
    case create(Parameters)
    case get(bearerToken: String)
    
    public var baseURL: URL {
        return URL(string: "http://localhost:8080")!
//        switch self {
//        case .create:
//            return URL(string: "http://localhost:8080")!
//        case .get:
//            return U
//        }
    }
    
    public var path: String {
        return "account"
//        switch self {
//        case .create:
//        return "account"
//        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .create:
            return .post
        case .get:
            return .get
        }
    }
    
    public var urlParameters: Parameters? {
        return nil
    }
    
    public var body: Parameters? {
        switch self {
        case .create(let params):
            return params
        case .get:
            return nil
        }
    }
    
    public var headers: HTTPHeaders? {
        switch self {
        case .create: return nil
        case .get(bearerToken: let token):
            return ["Authorization": "Bearer \(token)"]
        }
    }
    
}
