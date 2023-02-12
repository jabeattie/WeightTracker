import Quick
import Nimble

@testable import Core

class LocalWeightTests: QuickSpec {
    override func spec() {
        describe("LocalWeight") {
            it("should encode kilograms correctly") {
                let weight = LocalWeight.kilograms(kilograms: 70.1)
                let encoded = try! JSONEncoder().encode(weight)
                let string = String(data: encoded, encoding: .utf8)
                expect(string) == #"{"kilograms":{"kilograms":70.1}}"#
            }
            
            it("should encode pounds correctly") {
                let weight = LocalWeight.pounds(pounds: 154.3)
                let encoded = try! JSONEncoder().encode(weight)
                let string = String(data: encoded, encoding: .utf8)
                expect(string) == #"{"pounds":{"pounds":154.3}}"#
            }
            
            it("should encode stone correctly") {
                let weight = LocalWeight.stone(stone: 11, pounds: 4.3)
                let encoded = try! JSONEncoder().encode(weight)
                let string = String(data: encoded, encoding: .utf8)
                expect(string) == #"{"stone":{"stone":11,"pounds":4.3}}"#
            }
        }
    }
}
