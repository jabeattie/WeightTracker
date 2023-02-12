import Foundation


enum Method: String {
    case get = "GET"
    case post = "POST"
}

struct Request<Value> {
    let method: Method
    let path: String
    let queryParams: [String: String]
    let headers: [String: String]
}
