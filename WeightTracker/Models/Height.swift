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
    @objc dynamic var value: Int64 = 0
    
    var heightInMetres: Double {
        return Double(value) / 1000
    }
}
