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
        let weightInKgs = weight.weightInKgs
        let heightInMetres = height.heightInMetres
        return weightInKgs / (heightInMetres * heightInMetres)
    }
}
