//
//  User.swift
//  WeightTracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    enum MeasurementPreference: String {
        case imperial
        case metric
    }

    enum ActivityLevel: Int {
        case sedentary
        case moderate
        case active
        
        var calorieMultiplier: Double {
            switch self {
            case .active:
                return 1.4
            case .moderate:
                return 1.3
            case .sedentary:
                return 1.2
            }
        }
    }

    enum Sex: String {
        case male
        case female
    }
    
    @objc dynamic var height: Height?
    @objc dynamic var age: Int = 0
    @objc private dynamic var sexRaw: String?
    @objc private dynamic var preferenceRaw: String?
    @objc private dynamic var activityRaw: Int = 0
    @objc dynamic var targetWeight: TargetWeight?
    let pastWeights = List<Weight>()

    var currentWeight: Weight? {
        return pastWeights.sorted(byKeyPath: "date").last
    }

    var preference: MeasurementPreference {
        get {
            guard let raw = preferenceRaw else { return .metric }
            return MeasurementPreference(rawValue: raw) ?? .metric
        }
        set {
            preferenceRaw = newValue.rawValue
        }
    }

    var activityLevel: ActivityLevel {
        get {
            return ActivityLevel(rawValue: activityRaw) ?? .sedentary
        }
        set {
            activityRaw = newValue.rawValue
        }
    }

    var sex: Sex {
        get {
            guard let raw = sexRaw else { return .male }
            return Sex(rawValue: raw) ?? .male
        }
        set {
            sexRaw = newValue.rawValue
        }
    }
}
