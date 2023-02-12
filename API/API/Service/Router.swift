import Foundation
import Combine

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}

public protocol APIDataTaskPublisher {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
}

extension URLSession: APIDataTaskPublisher {}

public final class Router<Endpoint: EndpointType>: NetworkRouter {
    
    private let session: APIDataTaskPublisher
    
    public init(session: APIDataTaskPublisher = URLSession.shared) {
        self.session = session
    }
    
    public func request<Value: Codable>(_ route: Endpoint) -> AnyPublisher<Value, Error> {
        let decoder = JSONDecoder()
        do {
            let request = try self.buildRequest(from: route)
            return session
                .dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: Value.self, decoder: decoder)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch {
            let networkError = error as? NetworkError ?? NetworkError.encodingFailed
            return Publishers.NetworkErrorPublisher(error: networkError)
                .mapError({ $0 as Error })
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }
    
    private func buildRequest(from route: Endpoint) throws -> URLRequest {

        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        if let urlParameters = route.urlParameters {
            try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
        }
        if let body = route.body {
            try JSONParameterEncoder.encode(urlRequest: &request, with: body)
        }
        if let headers = route.headers {
            headers.forEach { header in
                request.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        return request
    }
}

extension Publishers {
    struct NetworkErrorPublisher<Value: Codable>: Publisher {
        
        typealias Output = Value
        typealias Failure = NetworkError
        
        private let error: Failure
        
        init(error: Failure) {
            self.error = error
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            subscriber.receive(completion: .failure(error))
        }
    }
}
