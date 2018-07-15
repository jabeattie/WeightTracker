//
//  EventBus.swift
//  WeightTracker
//
//  Created by James Beattie on 15/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

public protocol Event {}

public class EventBus {
    let internalSignal: Signal<Event, NoError>
    let internalObserver: Signal<Event, NoError>.Observer
    
    static let `default` = EventBus()
    
    init() {
        (internalSignal, internalObserver) = Signal<Event, NoError>.pipe()
    }
}
