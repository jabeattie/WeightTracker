import XCTest
import Quick
import Nimble
import Combine

@testable import API

private struct FakeEndpoint: EndpointType {
    var baseURL: URL = URL(string: "https://fake.com")!
    
    var path: String = "/getFake"
    
    var httpMethod: HTTPMethod = .get
    
    var task: HTTPTask = .request
    
    var headers: HTTPHeaders? = nil
}

class RouterTests: QuickSpec {
    
    override func spec() {
        describe("Router") {
            var subject: Router<FakeEndpoint>!
            
            beforeEach {
                let config = URLSessionConfiguration.ephemeral
                config.protocolClasses = [URLProtocolMock.self]
                let session = URLSession(configuration: config)
                subject = Router<FakeEndpoint>(session: session)
            }
            
            it("Should return a publisher for a valid route") {
                let publisher: AnyPublisher<Bool, Error> = subject.request(FakeEndpoint())
                expect(publisher.description) == "AnyPublisher"
            }
        }
    }

}
