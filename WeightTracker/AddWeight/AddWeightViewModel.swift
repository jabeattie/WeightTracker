//
//  AddWeightViewModel.swift
//  Weight tracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import Foundation
import RealmSwift

class AddWeightViewModel {
    private let configuration: Realm.Configuration
    private let userEventBus: UserEventBus
    private var user: User?
    
    private var realm: Realm? {
        return try? Realm(configuration: configuration)
    }
    
    init(configuration: Realm.Configuration = RealmService.default.configuration, userEventBus: UserEventBus = EventBus.default) {
        self.configuration = configuration
        self.userEventBus = userEventBus
        self.user = loadUser()
    }
    
    private func loadUser() -> User? {
        return realm?.objects(User.self).first
    }
    
    func add(weight kilograms: Double) {
        let measurement = Measurement<UnitMass>(value: kilograms, unit: .kilograms)
        let weight = Weight(measurement: measurement)
        do {
            try realm?.write {
                user?.pastWeights.append(weight)
            }
            userEventBus.send(event: .weightAdded)
        } catch let error {
            print(error)
        }
    }
}
