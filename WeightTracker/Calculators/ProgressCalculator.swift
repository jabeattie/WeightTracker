//
//  ProgressCalculator.swift
//  WeightTracker
//
//  Created by James Beattie on 15/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import Foundation

struct ProgressCalculator {
    
    struct WeightProgess {
        let progress: Double
        let delta: Weight
        let remaining: Weight
        let type: TargetWeight.TargetType
    }
    
    /// Calculates the BMI from a weight and height combination
    ///
    /// - Parameters:
    ///   - weight: weight of person in grams
    ///   - height: height of person in mms
    /// - Returns: the BMI value
    func calculate(targetWeight: TargetWeight, currentWeight: Weight) -> WeightProgess {
        guard let targetInKgs = targetWeight.target?.measurement.converted(to: .kilograms),
            let startInKgs = targetWeight.start?.measurement.converted(to: .kilograms)
            else {
                return WeightProgess(progress: 0.0, delta: Weight.zero, remaining: Weight.zero, type: targetWeight.targetType)
        }
        let currentInKgs = currentWeight.measurement.converted(to: .kilograms)
        
        let weightChange: Double
        let overallChange: Double
        switch targetWeight.targetType {
        case .gain:
            weightChange = currentInKgs.value - startInKgs.value
            overallChange = targetInKgs.value - startInKgs.value
        case .loss:
            weightChange = startInKgs.value - currentInKgs.value
            overallChange = startInKgs.value - targetInKgs.value
        }
        let progress: Double = weightChange / overallChange
        let changeMeasurement = Measurement<UnitMass>(value: weightChange, unit: .kilograms)
        let remainingMeasurement = Measurement<UnitMass>(value: overallChange - weightChange, unit: .kilograms)
        let delta: Weight = Weight(measurement: changeMeasurement)
        let remaining: Weight = Weight(measurement: remainingMeasurement)
        return WeightProgess(progress: progress, delta: delta, remaining: remaining, type: targetWeight.targetType)
    }
}
