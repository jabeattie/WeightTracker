//
//  Height.swift
//  Weight tracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import Foundation
import RealmSwift

class Height: Object {
    /// Height in mms
    @objc dynamic var value: Double = 0
    
    convenience init(figure: Double) {
        self.init()
        self.value = figure
    }
    
    var measurement: Measurement<UnitLength> {
        return Measurement(value: value, unit: UnitLength.millimeters)
    }
}
