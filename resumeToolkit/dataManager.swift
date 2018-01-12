//
//  dataManager.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/1/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class dataManager{
    var user: [NSManagedObject] = []
    var infoController = userInfo()
    
    init() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        var managedContext:NSManagedObjectContext
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        
        let userRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        //let timeRequest = NSFetchRequest<NSManagedObject>(entityName: "Time")
        do {
            user = try managedContext.fetch(userRequest)
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    
    
    func checkNameExistence() -> Bool{
        let appDel = UIApplication.shared.delegate as? AppDelegate
        
        var context:NSManagedObjectContext
        if #available(iOS 10.0, *) {
            context = (appDel?.persistentContainer.viewContext)!
        } else {
            // Fallback on earlier versions
            context = (appDel?.managedObjectContext)!
        }
        
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchrequest.predicate = NSPredicate(format: "firstName = %@", "")
        do {
            let fetchResults = try context.fetch(fetchrequest) as? NSManagedObject
            if fetchResults  != nil{
                return false
            }
        
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return true
    }
    
    
    
    
    
    func printStuff(){
        let aUser = user.last
        var firstname = aUser?.value(forKeyPath: "firstName") as? String
            //var lastname = aUser.value(forKeyPath: "lastName") as? String
        guard let lastname  = aUser?.value(forKeyPath: "lastName") as? String  else {
                print("nothing to see here")
                return
                
            
            
            
        }
        
        
        guard let email  = aUser?.value(forKeyPath: "emailAdress") as? String  else {
            print("nothing to see here")
            return
            
            
            
            
        }
        
        guard let phoneNumber  = aUser?.value(forKeyPath: "phoneNumber") as? String  else {
            print("nothing to see here")
            return
            
            
            
            
        }
        print(firstname! + " ______ " + lastname  + "______" + email + "_____" + phoneNumber)
    }
    
    var acounter = 0
    
    func printData(){
        loadData()
        
        
        for aUser in user{
            
            var courses = aUser.value(forKeyPath: "courses") as? String
            var extracurriculars = aUser.value(forKeyPath: "extracurriculars") as? String
            var experience = aUser.value(forKeyPath: "experience") as? String
            var skills = aUser.value(forKeyPath: "skills") as? String
            
            //print(String(acounter) + "courses: " + courses + "****" + "extracurriculars: " + extracurriculars +  "****" + "experience: " + experience + "****" + "Skills: " + skills)
            
            var printString = String(acounter) + "courses: "
            //printString.append(courses! + "****" + "extracurriculars: " + extracurriculars!)
           // printString += "****" + "experience: " + experience!
            //printString.append( "****" + "Skills: " + skills!)
            print(aUser)
            print("the length is" + String(user.count))
            acounter += 1
        }
        
        acounter = 0
        //ininfoController.save(screen: "main")
        
    }
    
    
    
    
    
    
    
    
    //saves first name of user
    func savefirstName(firstName: String) {
        loadData()
        
        //var firstNameCapitalized = firstName.replaceRange(firstName.startIndex...firstName.startIndex, with: String(firstName[firstName.startIndex]).capitalizedString)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        var managedContext:NSManagedObjectContext
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        
        let locationEntity = NSEntityDescription.entity(forEntityName: "User",
                                                        in: managedContext)!
        //savedObject
        let savedObject = NSManagedObject(entity: locationEntity,
                                          insertInto: managedContext)
       
        savedObject.setValue(firstName, forKeyPath: "firstName")
        
        
        if( user.last?.value(forKeyPath: "courses") != nil){
            savedObject.setValue(user.last?.value(forKeyPath: "courses") as! String ,forKeyPath: "courses")
        }
        if( user.last?.value(forKeyPath: "skills") != nil){
            savedObject.setValue(user.last?.value(forKeyPath: "skills") as! String ,forKeyPath: "skills")
        }
        if( user.last?.value(forKeyPath: "experience") != nil){
            savedObject.setValue(user.last?.value(forKeyPath: "experience") as! String ,forKeyPath: "experience")
        }
        if( user.last?.value(forKeyPath: "extracurriculars") != nil){
            savedObject.setValue(user.last?.value(forKeyPath: "extracurriculars") as! String ,forKeyPath: "extracurriculars")
        }
        if( user.last?.value(forKeyPath: "objective") != nil){
            savedObject.setValue(user.last?.value(forKeyPath: "objective") as! String ,forKeyPath: "objective")
        }
        
        
        let userRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do {
            try managedContext.save()
            user = try managedContext.fetch(userRequest)
            
            user.append(savedObject)
            print("First name saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    func saveLastName(lastName: String) {
        
        self.loadData()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        var managedContext:NSManagedObjectContext
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        
        do {
            
            user.last?.setValue(lastName, forKey: "lastName")
           try managedContext.save()
            
        }catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    
    
    
    func saveEmail(email: String) {
        
        self.loadData()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        var managedContext:NSManagedObjectContext
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        
        do {
            
            user.last?.setValue(email, forKey: "emailAdress")
            try managedContext.save()
            
        }catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    
    func savePhoneNumber(phoneNumber: String) {
        
        self.loadData()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        var managedContext:NSManagedObjectContext
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        
        do {
            
            user.last?.setValue(phoneNumber, forKey: "phoneNumber")
            try managedContext.save()
            
        }catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    
    
    func saveSchool(schoolName: String) {
        
        self.loadData()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        var managedContext:NSManagedObjectContext
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        
        do {
            
            user.last?.setValue(schoolName, forKey: "schoolName")
            try managedContext.save()
            
        }catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    
    
    
    
    //the one to change
    
    func saveSkills(theSkills: String) {
        
        self.loadData()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        var managedContext:NSManagedObjectContext
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        
        do {
            if( user.last?.value(forKeyPath: "skills") != nil){
                user.last?.setValue(user.last?.value(forKeyPath: "skills") as! String + "-" + theSkills ,forKeyPath: "skills")
            } else {
                user.last?.setValue(theSkills, forKey: "skills")
            }
            try managedContext.save()
            
        }catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        print(user.last)
    
    }
    
    
    
    func overwriteSkill(previousText: String, textToChangeTo: String) {
        self.loadData()
        print("previous text is" + previousText)
        print("new text is" + textToChangeTo)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        var managedContext:NSManagedObjectContext
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        
        var previousSkills = user.last?.value(forKeyPath: "skills") as! String
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        print(user.last)
        fetchrequest.predicate = NSPredicate(format: "skills == %@", previousSkills)
        do {
            let fetchResults = try managedContext.fetch(fetchrequest) as? [NSManagedObject]
            if fetchResults?.count != 0{
                var toSave = previousSkills.replacingOccurrences(of: previousText, with: textToChangeTo)
                
                print("to save is" + toSave)
                if(toSave.contains("--") || toSave == "-"){
                    toSave = toSave.replacingOccurrences(of: "-", with: "")
                    print("to save is NOW" + toSave)
                    
                }
                var managedObject = fetchResults?[0]
                
                user.last?.setValue(toSave, forKey: "skills")
                
               
                 print("updated skills")
            };try managedContext.save()
           print(user.last)
        } catch {
            print(error)
        }
    }
    
    
    
    func saveExperience(experience: String) {
        
        self.loadData()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        var managedContext:NSManagedObjectContext
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        
        do {
            if( user.last?.value(forKeyPath: "experience") != nil){
                user.last?.setValue(user.last?.value(forKeyPath: "experience") as! String + "-" +  experience,forKeyPath: "experience")
            } else {
                user.last?.setValue(experience, forKey: "experience")
            }
            try managedContext.save()
            
        }catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    
    func overwriteExperience(previousText: String, experienceToChangeTo: String) {
        self.loadData()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        var managedContext:NSManagedObjectContext
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        var previousExperience = user.last?.value(forKeyPath: "experience") as! String
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        fetchrequest.predicate = NSPredicate(format: "experience == %@", previousExperience)
        do {
            let fetchResults = try managedContext.fetch(fetchrequest) as? [NSManagedObject]
            if fetchResults?.count != 0{
                var toSave = previousExperience.replacingOccurrences(of: previousText, with: experienceToChangeTo)
                var managedObject = fetchResults?[0]
                if(toSave.contains("--") || toSave == "-"){
                    toSave = toSave.replacingOccurrences(of: "-", with: "")
                    
                }
                user.last?.setValue(toSave, forKey: "experience")
                
                
                print("experience Update")
            };try managedContext.save()
            print(user.last)
        } catch {
            print(error)
        }
    }
    
    
    
    
    
    
    
    
    
    
    func saveCourses(courses: String) {
        
        loadData()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        var managedContext:NSManagedObjectContext
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        
        do {
            if( user.last?.value(forKeyPath: "courses") != nil){
                user.last?.setValue(user.last?.value(forKeyPath: "courses") as! String + "-" + courses,forKeyPath: "courses")
            } else {
                user.last?.setValue(courses, forKey: "courses")
            }
            
            try managedContext.save()
            
        }catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    
    
    
    func overwriteCourses(previousText: String, courseToChangeTo: String) {
        self.loadData()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        var managedContext:NSManagedObjectContext
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        var previousCourses = user.last?.value(forKeyPath: "courses") as! String
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        print(user.last)
        fetchrequest.predicate = NSPredicate(format: "courses == %@", previousCourses)
        do {
            let fetchResults = try managedContext.fetch(fetchrequest) as? [NSManagedObject]
            if fetchResults?.count != 0{
                var toSave = previousCourses.replacingOccurrences(of: previousText, with: courseToChangeTo)
                var managedObject = fetchResults?[0]
                if(toSave.contains("--") || toSave == "-"){
                    toSave = toSave.replacingOccurrences(of: "-", with: "")
                    
                }
                
                user.last?.setValue(toSave, forKey: "courses")
                
                
                print("courses Updated")
            };try managedContext.save()
            print(user.last)
        } catch {
            print(error)
        }
    }
    
    
    
    
    
    
    
    
    
    func saveExtracurriculars(extracurricular: String) {
        self.loadData()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        var managedContext:NSManagedObjectContext
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        
        do {
            if( user.last?.value(forKeyPath: "extracurriculars") != nil){
                user.last?.setValue(user.last?.value(forKeyPath: "extracurriculars") as! String + "-" + extracurricular,forKeyPath: "extracurriculars")
            } else {
                user.last?.setValue(extracurricular, forKey: "extracurriculars")
            }
            
            try managedContext.save()
            
        }catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    
    
    func overwriteExtracurriculars(previousText: String, extraCurricularToReplace: String) {
        self.loadData()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        
        var managedContext:NSManagedObjectContext
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        var previousExtracurriculars = user.last?.value(forKeyPath: "extracurriculars") as! String
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        print(user.last)
        fetchrequest.predicate = NSPredicate(format: "extracurriculars == %@", previousExtracurriculars)
        do {
            let fetchResults = try managedContext.fetch(fetchrequest) as? [NSManagedObject]
            if fetchResults?.count != 0{
                var toSave = previousExtracurriculars.replacingOccurrences(of: previousText, with: extraCurricularToReplace)
                
                if(toSave.contains("--") || toSave == "-"){
                    toSave = toSave.replacingOccurrences(of: "-", with: "")
                    
                }
                var managedObject = fetchResults?[0]
                
                user.last?.setValue(toSave, forKey: "extracurriculars")
                
               
                
                
                print("extracurriculars Updated")
            };try managedContext.save()
            print(user.last)
        } catch {
            print(error)
        }
    }
    
    
    
    
    
    
    func saveObjective(statement: String) {
        loadData()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        var managedContext:NSManagedObjectContext
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        
        do {
            
            user.last?.setValue(statement, forKey: "objective")
            try managedContext.save()
            
        }catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        
    }
    
    
    func loadData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        if #available(iOS 10.0, *) {
            let managedContext = appDelegate.persistentContainer.viewContext
            let userRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
            //let timeRequest = NSFetchRequest<NSManagedObject>(entityName: "Time")
            do {
                user = try managedContext.fetch(userRequest)
                
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        } else {
            // Fallback on earlier versions
            let managedContext = appDelegate.managedObjectContext
            let userRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
            //let timeRequest = NSFetchRequest<NSManagedObject>(entityName: "Time")
            do {
                user = try managedContext.fetch(userRequest)
                
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
        
        
    }
    
    
    
    
}
