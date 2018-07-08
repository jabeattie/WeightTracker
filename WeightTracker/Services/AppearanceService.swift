//
//  AppearanceService.swift
//  WeightTracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import UIKit

class AppearanceService: NSObject, UIApplicationDelegate {
    
    static let `default` = RealmService()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UITabBar.appearance().tintColor = UIColor.wtRed
        
        return true
    }
}
