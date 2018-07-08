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
    @objc dynamic var value: Int64 = 0
    
    var weightInKgs: Double {
        return Double(value) / 1000
    }
}
