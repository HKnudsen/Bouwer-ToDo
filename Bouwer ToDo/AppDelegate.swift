//
//  AppDelegate.swift
//  Bouwer ToDo
//
//  Created by Henrik Bouwer Knudsen on 13/05/2019.
//  Copyright © 2019 Henrik Bouwer Knudsen. All rights reserved.
//

import UIKit

import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        
        //Shows file path for realm
        print(Realm.Configuration.defaultConfiguration.fileURL)
        

        
       
        
        do {
            _ = try Realm()
            
        } catch {
            print("Error Initializing new realm, \(error)")
        }
        
        return true
    }

    
    // MARK: - Core Data stack
    
}
