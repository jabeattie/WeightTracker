import Foundation

public struct User: Codable {
    let id: Int?
    let email: String?
    let gender: Gender
    let dob: String?
    let heightUnit: HeightUnit
    let weightUnit: WeightUnit
    let height: Int
    let physicalActivityProfile: PhysicalActivityProfile
}
