//
//  DashboardViewModel.swift
//  Weight tracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import Foundation
import RealmSwift
import ReactiveSwift
import Result

class DashboardViewModel {
    let updateSignal: Signal<Void, NoError>
    
    private let configuration: Realm.Configuration
    private let userEventBus: UserEventBus
    private let updateObserver: Signal<Void, NoError>.Observer
    private var user: User?
    
    private var realm: Realm? {
        return try? Realm(configuration: configuration)
    }
    
    init(configuration: Realm.Configuration = RealmService.default.configuration, userEventBus: UserEventBus = EventBus.default) {
        self.configuration = configuration
        self.userEventBus = userEventBus
        (updateSignal, updateObserver) = Signal<Void, NoError>.pipe()
        self.user = loadUser()
    }
    
    private func listenForEvents() {
        userEventBus.userEvents.observeValues { [weak self] (_) in
            self?.updateObserver.send(value: ())
        }
    }
    
    private func loadUser() -> User? {
        return realm?.objects(User.self).first
    }
    
    private var weightDecorator: WeightDecorator {
        let pref = user?.preference ?? .metric
        return WeightDecorator(preference: pref)
    }
    
    public var currentWeightCellViewModel: CurrentWeightCellViewModel {
        return CurrentWeightCellViewModel(user: user, decorator: weightDecorator)
    }
    
    public var bmiCellViewModel: BMICellViewModel {
        return BMICellViewModel(user: user, calculator: BMICalculator())
    }
    
    public var dailyTargetCellViewModel: DailyTargetCellViewModel {
        return DailyTargetCellViewModel(user: user, calculator: CalorieCalculator())
    }
    
    public var progressCellViewModel: ProgressCellViewModel {
        return ProgressCellViewModel(user: user, calculator: ProgressCalculator(), decorator: weightDecorator)
    }
}
