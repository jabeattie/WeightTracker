import Quick
import Nimble

@testable import WeightTracker

class CalorieCalculatorTests: QuickSpec {
    
    override func spec() {
        describe("CalorieCalulator") {
            it("should return the correct value for a male") {
                let calculator = CalorieCalculator()
                
                let user = User()
                user.age = 29
                user.activityLevel = User.ActivityLevel.moderate
                user.targetWeight = Weight(figure: 78000)
                user.height = Height(figure: 1780)
                
                expect(calculator.calculate(user: user)).to(beCloseTo(2278.25))
            }
            
            it("should return the correct value for a female") {
                let calculator = CalorieCalculator()
                
                let user = User()
                user.age = 29
                user.sex = .female
                user.activityLevel = User.ActivityLevel.moderate
                user.targetWeight = Weight(figure: 78000)
                user.height = Height(figure: 1780)
                
                expect(calculator.calculate(user: user)).to(beCloseTo(2062.45))
            }
        }
    }
}
