//
//  DashboardViewModel.swift
//  Weight tracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import Foundation
import RealmSwift

class DashboardViewModel {
    private let configuration: Realm.Configuration
    private var user: User?
    
    private var realm: Realm? {
        return try? Realm(configuration: configuration)
    }
    
    init(configuration: Realm.Configuration = RealmService.default.configuration) {
        self.configuration = configuration
        self.user = loadUser()
    }
    
    private func loadUser() -> User? {
        return realm?.objects(User.self).first
    }
    
    public var currentWeightCellViewModel: CurrentWeightCellViewModel {
        let pref = user?.preference ?? .metric
        let decorator = WeightDecorator(preference: pref)
        return CurrentWeightCellViewModel(user: user, decorator: decorator)
    }
    
    public var bmiCellViewModel: BMICellViewModel {
        return BMICellViewModel(user: user, calculator: BMICalculator())
    }
    
    public var dailyTargetCellViewModel: DailyTargetCellViewModel {
        return DailyTargetCellViewModel(user: user, calculator: CalorieCalculator())
    }
}
