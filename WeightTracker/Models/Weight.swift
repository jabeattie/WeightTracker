//
//  Weight.swift
//  Weight tracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import Foundation
import RealmSwift

class Weight: Object {
    /// Weight in grams
    @objc dynamic var value: Double = 0
    @objc dynamic var date: Date = Date()
    
    convenience init(measurement: Measurement<UnitMass>, date: Date = Date()) {
        self.init()
        self.value = measurement.converted(to: .grams).value
        self.date = date
    }
    
    convenience init(figure: Double, date: Date = Date()) {
        self.init()
        self.value = figure
        self.date = date
    }
    
    static var zero: Weight {
        return Weight(figure: 0)
    }
    
    var measurement: Measurement<UnitMass> {
        return Measurement(value: value, unit: UnitMass.grams)
    }
}
