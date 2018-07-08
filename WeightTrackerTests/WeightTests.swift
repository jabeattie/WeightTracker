import Quick
import Nimble

@testable import WeightTracker

class WeightTests: QuickSpec {
    
    override func spec() {
        describe("Weight") {
            it("Should return the correct weight in kgs") {
                let weight = Weight()
                weight.value = 20000
                
                expect(weight.measurement.value).to(equal(20000.0))
            }
        }
    }
}
