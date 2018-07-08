import Quick
import Nimble

@testable import WeightTracker

class HeightTests: QuickSpec {
    
    override func spec() {
        describe("Height") {
            it("Should return the correct height in metres") {
                let height = Height()
                height.value = 2000
                
                expect(height.measurement.value).to(equal(2000.0))
            }
        }
    }
}
