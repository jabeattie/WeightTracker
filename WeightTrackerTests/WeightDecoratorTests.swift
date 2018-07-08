import Quick
import Nimble

@testable import WeightTracker

class WeightDecoratorTests: QuickSpec {
    
    override func spec() {
        describe("WeightDecorator") {
            it("should return the value formatted as stones and lbs") {
                let decorator = WeightDecorator(preference: .imperial)
                let weight = Weight(figure: 78000)
                expect(decorator.displayValue(for: weight)).to(equal("12 st 4 lb"))
            }
            
            it("should return the value formatted as kgs") {
                let decorator = WeightDecorator(preference: .metric)
                let weight = Weight(figure: 78100)
                expect(decorator.displayValue(for: weight)).to(equal("78.1 kg"))
            }
        }
    }
}
