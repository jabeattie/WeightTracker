//
//  WeightDecorator.swift
//  WeightTracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import Foundation

struct WeightDecorator {
    private let preference: User.MeasurementPreference
    private let formatter: MeasurementFormatter
    
    init(preference: User.MeasurementPreference) {
        self.preference = preference
        formatter = MeasurementFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.unitStyle = .short
    }
    
    func displayValue(for weight: Weight) -> String? {
        switch preference {
        case .imperial:
            let stones = weight.measurement.converted(to: UnitMass.stones)
            let singleUnit = Measurement(value: 1, unit: UnitMass.stones)
            let remainderStones = stones.value.truncatingRemainder(dividingBy: singleUnit.value)
            let poundsUnit = Measurement(value: remainderStones, unit: UnitMass.stones).converted(to: UnitMass.pounds)
            let numberFormatter = NumberFormatter()
            numberFormatter.maximumFractionDigits = 0
            formatter.numberFormatter = numberFormatter
            return "\(formatter.string(from: stones)) \(formatter.string(from: poundsUnit))"
        case .metric:
            let kgs = weight.measurement.converted(to: UnitMass.kilograms)
            let numberFormatter = NumberFormatter()
            numberFormatter.maximumFractionDigits = 1
            formatter.numberFormatter = numberFormatter
            return formatter.string(from: kgs)
        }
    }
}
