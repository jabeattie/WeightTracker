public enum WeightUnit: String, Codable, CaseIterable {
    case kg = "KILOGRAM"
    case stone = "STONE"
    case pounds = "POUNDS"
}

public extension WeightUnit {
    init(displayValue: String) {
        switch displayValue {
        case WeightUnit.kg.displayValue:
            self = .kg
        case WeightUnit.stone.displayValue:
            self = .stone
        case WeightUnit.pounds.displayValue:
            self = .pounds
        default:
            fatalError("Programmer error")
        }
    }
    
    var displayValue: String {
        switch self {
        case .kg: return "KG"
        case .stone: return "Stone"
        case .pounds: return "Pounds"
        }
    }
}
