import Foundation
import Combine

enum APIError: Error {
    case networkError
    case parsingError
}

extension URL {
    func url(with queryItems: [URLQueryItem]) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        components.queryItems = (components.queryItems ?? []) + queryItems
        return components.url!
    }
    
    init<Value>(_ host: String, _ request: Request<Value>) {
        let queryParams = request.queryParams
        
        let queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        let url = URL(string: host)!
            .appendingPathComponent(request.path)
            .url(with: queryItems)
        
        self.init(string: url.absoluteString)!
    }
}

protocol API {
    func execute<Value: Decodable>(_ request: Request<Value>) -> AnyPublisher<Value, Error>
}

final class APIManager: API {
    
    static let shared = APIManager()
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func execute<Value>(_ request: Request<Value>) -> AnyPublisher<Value, Error> where Value : Decodable {
        let decoder = JSONDecoder()
        let urlRequest = self.urlRequest(for: request)
        let session = urlSession
        return session
            .dataTaskPublisher(for: urlRequest)
            .map({ $0.data })
            .decode(type: Value.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    private func urlRequest<Value>(for request: Request<Value>) -> URLRequest {
        let url = URL("http://127.0.0.1", request)
        var result = URLRequest(url: url)
        result.httpMethod = request.method.rawValue
        request.headers.forEach {
            result.addValue($0.key, forHTTPHeaderField: $0.value)
        }
        return result
    }
}
