//
//  userInfo.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/6/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import CoreData

class userInfo {
    var managedObjectContext: NSManagedObjectContext?
    //stores the keys for settings values
    struct defaultsKeys {
        static let screenToShow = "login"
        static let changeText = "bbb"
        
        
        
    }
    //returns the current values of setting keys
    func fetchData()  -> String{
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: defaultsKeys.screenToShow) {
            // Some String Value
            return stringOne
        }
        return "login"
    }
    
    
    
    
    
    //alters the value of the setting keys
    func save(screen: String) {
        let defaults = UserDefaults.standard
        defaults.set(screen, forKey: defaultsKeys.screenToShow)
        //defaults.set("Another String Value", forKey: defaultsKeys.keyTwo)
        
        
    }
    
    
    func saveChangeText(text: String) {
        let defaults = UserDefaults.standard
        defaults.set(text, forKey: defaultsKeys.changeText)
        //defaults.set("Another String Value", forKey: defaultsKeys.keyTwo)
        
        
    }
}
