//
//  CalorieCalculator.swift
//  WeightTracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import Foundation

/// Calorie calulator based upon the Mifflin-St. Jeor equation
struct CalorieCalculator {
    
    private func sexAdditive(sex: User.Sex) -> Double {
        switch sex {
        case .female:
            return -161
        case .male:
            return 5
        }
    }
    
    /// Calculates the estimated required calories to maintain a certain weight
    ///
    /// - Parameters:
    ///   - weight: weight of person in grams
    ///   - age: age of person in years
    /// - Returns: the BMI value
    func calculate(user: User) -> Double {
        let optionalWeight = user.targetWeight?.target ?? user.currentWeight
        guard let weight = optionalWeight, let height = user.height else { return 0 }
        
        let weightInKgs = weight.measurement.converted(to: UnitMass.kilograms).value
        let heightInCm = height.measurement.converted(to: UnitLength.centimeters).value
        let age = Double(user.age)
        
        let baseLevel = 10 * weightInKgs + 6.25 * heightInCm - 5 * age + sexAdditive(sex: user.sex)
        return baseLevel * user.activityLevel.calorieMultiplier
    }
}
