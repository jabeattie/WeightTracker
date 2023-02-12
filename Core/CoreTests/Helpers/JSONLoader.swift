import Foundation

final class JSONLoader {
    static func load<T: Decodable>(filename: String, extension fileExtension: String = "json") throws -> T {
        let bundle = Bundle(for: JSONLoader.self)
        guard let url = bundle.url(forResource: filename, withExtension: fileExtension) else {
            throw NSError(domain: "1", code: 1, userInfo: nil)
        }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
