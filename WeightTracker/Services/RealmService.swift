//
//  RealmService.swift
//  Weight tracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import UIKit
import RealmSwift

class RealmService: NSObject, UIApplicationDelegate {
    
    static let `default` = RealmService()
    
    private(set) var configuration: Realm.Configuration = Realm.Configuration.defaultConfiguration
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        var config = Realm.Configuration.defaultConfiguration
        
        config.deleteRealmIfMigrationNeeded = true
        config.schemaVersion = 1
        config.migrationBlock = { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                
            }
        }
        
        _ = try? Realm(configuration: config)
        Realm.Configuration.defaultConfiguration = config
        configuration = config
        print(config.fileURL!.absoluteString)
        
        return true
    }
}
