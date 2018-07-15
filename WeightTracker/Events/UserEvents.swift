//
//  UserEvents.swift
//  WeightTracker
//
//  Created by James Beattie on 15/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

enum UserEvent: Event {
    case weightAdded
    case targetChanged
}

protocol UserEventBus {
    var userEvents: Signal<UserEvent, NoError> { get }
    func send(event: UserEvent)
}

extension EventBus: UserEventBus {
    var userEvents: Signal<UserEvent, NoError> {
        return internalSignal.filterMap({ $0 as? UserEvent })
    }
    
    func send(event: UserEvent) {
        internalObserver.send(value: event)
    }
}
