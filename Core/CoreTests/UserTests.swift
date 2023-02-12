import Nimble
import Quick

@testable import Core

class UserTests: QuickSpec {

    override func spec() {
        describe("User") {
            var subject: User!
            
            beforeEach {
                subject = try! JSONLoader.load(filename: "account")
            }
            
            it("should have correct weightUnit") {
                expect(subject.weightUnit) == WeightUnit.kg
            }
            
            it("should have correct weightUnit") {
                expect(subject.physicalActivityProfile) == PhysicalActivityProfile.heavy
            }
            
            it("should have correct weightUnit") {
                expect(subject.gender) == Gender.male
            }
            
            it("should have correct heightUnit") {
                expect(subject.heightUnit) == HeightUnit.cm
            }
        }
        
        describe("User - Alternative") {
            var subject: User!
            
            beforeEach {
                subject = try! JSONLoader.load(filename: "account-imperial")
            }
            
            it("should have correct weightUnit") {
                expect(subject.weightUnit) == WeightUnit.stone
            }
            
            it("should have correct weightUnit") {
                expect(subject.physicalActivityProfile) == PhysicalActivityProfile.light
            }
            
            it("should have correct weightUnit") {
                expect(subject.gender) == Gender.female
            }
            
            it("should have correct heightUnit") {
                expect(subject.heightUnit) == HeightUnit.feet
            }
        }
    }

}
