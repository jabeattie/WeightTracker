//
//  TargetWeight.swift
//  WeightTracker
//
//  Created by James Beattie on 15/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import Foundation
import RealmSwift

class TargetWeight: Object {
    
    enum TargetType {
        case gain
        case loss
        
        var displayValue: String {
            switch self {
            case .gain:
                return "Gained"
            case .loss:
                return "Lost"
            }
        }
    }
    
    /// Weight when target set in grams
    @objc dynamic var start: Weight?
    /// Target weight in grams
    @objc dynamic var target: Weight?
    
    convenience init(start: Weight, target: Weight, date: Date = Date()) {
        self.init()
        self.start = start
        self.target = target
    }
    
    var targetType: TargetType {
        guard let start = start, let target = target else { return .loss }
        return start.value > target.value ? .loss : .gain
    }
}
