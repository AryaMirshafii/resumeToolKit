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
        static let resumeFilePath = "noFile"
        static let folderID = "noFolder"
        static let resumeIndex = "0"
        
        
        
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
    
    
    func fetchChangeText()  -> String{
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: defaultsKeys.changeText) {
            // Some String Value
            return stringOne
        }
        return "bbb"
    }
    // commented out since login screen does not work
    
    /**
    
    func saveResumeFilePath(filePath: String) {
        let defaults = UserDefaults.standard
        defaults.set(filePath, forKey: defaultsKeys.resumeFilePath)
        //defaults.set("Another String Value", forKey: defaultsKeys.keyTwo)
        
        
        
        
        
    }
    
    func getFilePath()  -> String{
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: defaultsKeys.resumeFilePath) {
            // Some String Value
            return stringOne
        }
        return "noFile"
    }
    
    
    
    */
    
    func saveFolderID(folderID: String) {
        let defaults = UserDefaults.standard
        defaults.set(folderID, forKey: defaultsKeys.folderID)
    }
    func getFolderID()  -> String{
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: defaultsKeys.folderID) {
            // Some String Value
            return stringOne
        }
        return "noFolder"
    }
    
    func saveResumeIndex(resumeIndexAt: String) {
        let defaults = UserDefaults.standard
        defaults.set(resumeIndexAt, forKey: defaultsKeys.resumeIndex)
    }
    func getResumeIndex()  -> String{
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: defaultsKeys.resumeIndex) {
            // Some String Value
            return stringOne
        }
        return "0"
    }
    
}
