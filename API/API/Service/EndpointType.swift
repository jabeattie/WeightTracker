import Foundation

public typealias HTTPHeaders = [String: String] 

public protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var urlParameters: Parameters? { get }
    var body: Parameters? { get }
    var headers: HTTPHeaders? { get }
}
