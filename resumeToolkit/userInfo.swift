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
    var context: NSManagedObjectContext!
    //stores the keys for settings values
    struct defaultsKeys {
        static let screenToShow = "login"
        static let changeText = "bbb"
        static let resumeFilePath = "noFile"
        static let folderID = "noFolder"
        static let resumeIndex = "0"
        static let jobExperience = "Internship & Job Experience"
        static let skills = "Skills"
        static let courses = "Courses"
        static let extracurriculars = "Extracurriculars"
        static let tutorialProgress = 0
        
        
        
    }
    
    init(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        if #available(iOS 10.0, *) {
            context = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            context = appDelegate.managedObjectContext
        }
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
    
    /**
    // commented out since login screen does not work
    
    
    
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
            print("The current resume index according to coreData is: " + stringOne)
            return stringOne
        }
        print("The current resume index according to coreData is:0")
        return "0"
    }
    
    func savejobExperience(experience: String) {
        let defaults = UserDefaults.standard
        defaults.set(experience, forKey: defaultsKeys.jobExperience)
    }
    func getjobExperience()  -> String{
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: defaultsKeys.jobExperience) {
            // Some String Value
            return stringOne
        }
        return "0"
    }
    
    
    func getProgress()  -> Int{
        let defaults = UserDefaults.standard
        /**
        if let stringOne = defaults.string(forKey: "tutorialProgress") {
            // Some String Value
            return Double(stringOne)!
        }
        print("returning 0")
        if(self.fetchData() == "login"){
            print("In Login Screen")
            return 0
        }
        return 99
        */
        return defaults.integer(forKey: "tutorialProgress")
    }
    
    func incrementTutorialProgress() {
        let defaults = UserDefaults.standard
        print("Incrementing progress")
        let newcount = getProgress() + 1
        print("the old count is " + String(defaultsKeys.tutorialProgress) + " the new is " + String(newcount))
        defaults.set(newcount, forKey: "tutorialProgress")
        print("The tutorial count is:" + String(defaultsKeys.tutorialProgress))
        do{
            try context.save()
        }catch{
            
        }
        
        
    }
    func restartTutorial() {
       
        print("Tutorial has been restarted")
        let defaults = UserDefaults.standard
        defaults.set(1, forKey: "tutorialProgress")
        do{
            try context.save()
        }catch{
            
        }
    }
    
    func disableTutorial(){
        print("Tutorial has been disabled")
        let defaults = UserDefaults.standard
        defaults.set(99, forKey: "tutorialProgress")
        
        
        
        do{
            try context.save()
        }catch{
            
        }
        
    }
    
    func refresh(){
        context.refreshAllObjects()
    }
    
    func isTutorailComplete()  -> Bool{
        let defaults = UserDefaults.standard
        print("the progress before checking is" + String(getProgress()))
        if(getProgress() > 15){
            print("The tutorial is Complete")
            return true
        }
        return false
    }
    
    
    
    
    
}
