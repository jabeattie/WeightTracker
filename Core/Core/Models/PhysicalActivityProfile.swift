import Foundation

public enum PhysicalActivityProfile: String, Codable, CaseIterable {
    case sedentary = "SEDENTARY"
    case light = "LIGHT"
    case moderate = "MODERATE"
    case heavy = "HEAVY"
    case intensive = "INTENSIVE"
}

public extension PhysicalActivityProfile {
    var displayName: String {
        switch self {
        case .sedentary:
            return "Sedentry"
        case .light:
            return "Lightly active"
        case .moderate:
            return "Moderately active"
        case .heavy:
            return "Very active"
        case .intensive:
            return "Extra active"
        }
    }
    
    var displaySubtitle: String {
        switch self {
        case .sedentary:
            return "little to no exercise"
        case .light:
            return "exercise 1 to 3 times per week"
        case .moderate:
            return "exercise 3 to 5 times per week"
        case .heavy:
            return "exercise 6 to 7 times per week"
        case .intensive:
            return "very hard exercise, sports or physical job"
        }
    }
}
