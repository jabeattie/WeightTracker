import Quick
import Nimble

@testable import WeightTracker

class BMICalculatorTests: QuickSpec {
    
    override func spec() {
        describe("BMICalculator") {
            it("Should return the correct BMI for the height and weight") {
                let height = Height()
                height.value = 1700
                let weight = Weight()
                weight.value = 60000
                
                let calculator = BMICalculator()
                expect(calculator.calculate(weight: weight, height: height)).to(beCloseTo(20.761, within: 0.001))
            }
        }
    }
}
