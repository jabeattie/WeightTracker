//
//  BMICalculator.swift
//  Weight tracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import Foundation

struct BMICalculator {
    
    /// Calculates the BMI from a weight and height combination
    ///
    /// - Parameters:
    ///   - weight: weight of person in grams
    ///   - height: height of person in mms
    /// - Returns: the BMI value
    func calculate(weight: Weight, height: Height) -> Double {
        let weightInKgs = weight.measurement.converted(to: UnitMass.kilograms)
        let heightInMetres = height.measurement.converted(to: UnitLength.meters)
        return weightInKgs.value / (heightInMetres.value * heightInMetres.value)
    }
}
