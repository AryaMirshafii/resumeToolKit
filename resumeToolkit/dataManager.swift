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
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        //let timeRequest = NSFetchRequest<NSManagedObject>(entityName: "Time")
        do {
            user = try managedContext.fetch(userRequest)
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        //checkNillObjects()
        
        //self.printStuff()
    }
    func checkNillObjects(){
        loadData()
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        if(user != nil && user.count > 2){
            for anIndex in 0...(user.count-1){
                print(String(anIndex))
                if((anIndex <= (user.count - 1)) && (String(describing: user[anIndex].value(forKeyPath: "firstName")) == "" || String(describing: user[anIndex].value(forKeyPath: "lastName")) == "" || user[anIndex].value(forKeyPath: "phoneNumber") == nil || user[anIndex].value(forKeyPath: "schoolName") == nil || user[anIndex].value(forKeyPath: "emailAdress") == nil )){
                    context.delete(self.user[anIndex])
                    self.user.remove(at: anIndex)
                    
                }
            }
            
            do {
                try context.save()
            } catch _ {
            }
            
        }
    }
    
    
    func checkNameExistence() -> Bool{
        let appDel = UIApplication.shared.delegate as? AppDelegate
        
        let context = appDel?.persistentContainer.viewContext
        
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchrequest.predicate = NSPredicate(format: "firstName = %@", "")
        do {
            let fetchResults = try context?.fetch(fetchrequest) as? NSManagedObject
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
        //checkNillObjects()
        
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
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
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
        
        
        loadData()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let locationEntity = NSEntityDescription.entity(forEntityName: "User",
                                                        in: managedContext)!
        //savedObject
        let savedObject = NSManagedObject(entity: locationEntity,
                                          insertInto: managedContext)
        
        savedObject.setValue(lastName, forKeyPath: "lastName")
        guard let firstName  = user.last?.value(forKeyPath: "firstName") else {
            print("No name to submit")
            return
        }
        
        savedObject.setValue(firstName,forKeyPath: "firstName")
        
        
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
            print("Last name saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    
    func saveEmail(email: String) {
        
        loadData()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let locationEntity = NSEntityDescription.entity(forEntityName: "User",
                                                        in: managedContext)!
        //savedObject
        let savedObject = NSManagedObject(entity: locationEntity,
                                          insertInto: managedContext)
        
        savedObject.setValue(email, forKeyPath: "emailAdress")
        guard let firstName  = user.last?.value(forKeyPath: "firstName") else {
            print("No first name to submit")
            return
        }
        
        savedObject.setValue(firstName,forKeyPath: "firstName")
        
        
        
        
        guard let lastName  = user.last?.value(forKeyPath: "lastName") else {
            print("No last name to submit")
            return
        }
        
        savedObject.setValue(lastName,forKeyPath: "lastName")
        
        
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
            print("email Saved!")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func savePhoneNumber(phoneNumber: String) {
        
        loadData()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let locationEntity = NSEntityDescription.entity(forEntityName: "User",
                                                        in: managedContext)!
        //savedObject
        let savedObject = NSManagedObject(entity: locationEntity,
                                          insertInto: managedContext)
        
        savedObject.setValue(phoneNumber, forKeyPath: "phoneNumber")
        guard let firstName  = user.last?.value(forKeyPath: "firstName") else {
            print("No first name to submit")
            return
        }
        
        savedObject.setValue(firstName,forKeyPath: "firstName")
        
        
        
        
        guard let lastName  = user.last?.value(forKeyPath: "lastName") else {
            print("No last name to submit")
            return
        }
        
        savedObject.setValue(lastName,forKeyPath: "lastName")
        
        
        
        guard let email  = user.last?.value(forKeyPath: "emailAdress") else {
            print("No email to submit")
            return
        }
        
        savedObject.setValue(email,forKeyPath: "emailAdress")
        
        
        
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
            print("phone number Saved!")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    func saveSchool(schoolName: String) {
        
        loadData()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let locationEntity = NSEntityDescription.entity(forEntityName: "User",
                                                        in: managedContext)!
        //savedObject
        let savedObject = NSManagedObject(entity: locationEntity,
                                          insertInto: managedContext)
        
        savedObject.setValue(schoolName, forKeyPath: "schoolName")
        guard let firstName  = user.last?.value(forKeyPath: "firstName") else {
            print("No first name to submit")
            return
        }
        
        savedObject.setValue(firstName,forKeyPath: "firstName")
        
        
        
        
        guard let lastName  = user.last?.value(forKeyPath: "lastName") else {
            print("No last name to submit")
            return
        }
        
        savedObject.setValue(lastName,forKeyPath: "lastName")
        
        
        
        guard let email  = user.last?.value(forKeyPath: "emailAdress") else {
            print("No email to submit")
            return
        }
        
        savedObject.setValue(email,forKeyPath: "emailAdress")
        
        
        
        guard let phoneNumber  = user.last?.value(forKeyPath: "phoneNumber") else {
            print("No phoneNumber to submit")
            return
        }
        
        savedObject.setValue(phoneNumber,forKeyPath: "phoneNumber")
        
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
            print("school name Saved!")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    
    
    //the one to change
    
    func saveSkills(theSkills: String) {
        
        loadData()
        
        var aSkill = theSkills
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let locationEntity = NSEntityDescription.entity(forEntityName: "User",
                                                        in: managedContext)!
        //savedObject
        let savedObject = NSManagedObject(entity: locationEntity,
                                          insertInto: managedContext)
        
        
        
        
        
        
        if( user.last?.value(forKeyPath: "skills") != nil){
            aSkill += ("-" + (user.last?.value(forKeyPath: "skills") as! String))
            savedObject.setValue(aSkill, forKeyPath: "skills")
            
        } else {
            savedObject.setValue(( theSkills), forKeyPath: "skills")
        }
        
        
        
        
        guard let firstName  = user.last?.value(forKeyPath: "firstName") else {
            print("No first name to submit")
            return
        }
        
        savedObject.setValue(firstName,forKeyPath: "firstName")
        
        
        
        
        guard let lastName  = user.last?.value(forKeyPath: "lastName") else {
            print("No last name to submit")
            return
        }
        
        savedObject.setValue(lastName,forKeyPath: "lastName")
        
        
        
        guard let email  = user.last?.value(forKeyPath: "emailAdress") else {
            print("No email to submit")
            return
        }
        
        savedObject.setValue(email,forKeyPath: "emailAdress")
        
        
        
        guard let phoneNumber  = user.last?.value(forKeyPath: "phoneNumber") else {
            print("No phoneNumber to submit")
            return
        }
        
        savedObject.setValue(phoneNumber,forKeyPath: "phoneNumber")
        
        guard let schoolName  = user.last?.value(forKeyPath: "schoolName") else {
            print("No phoneNumber to submit")
            return
        }
        
        savedObject.setValue(schoolName,forKeyPath: "schoolName")
        
        
       
        
        
        
        
        if( user.last?.value(forKeyPath: "courses") != nil){
            savedObject.setValue(user.last?.value(forKeyPath: "courses") as! String ,forKeyPath: "courses")
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
            print("skills Saved!")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        print(user.count)
    }
    
    
    
    func saveExperience(experience: String) {
        
        loadData()
        var anExperience = experience
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let locationEntity = NSEntityDescription.entity(forEntityName: "User",
                                                        in: managedContext)!
        //savedObject
        let savedObject = NSManagedObject(entity: locationEntity,
                                          insertInto: managedContext)
        
        
        if( user.last?.value(forKeyPath: "experience") != nil){
            anExperience += ("-" + (user.last?.value(forKeyPath: "experience") as! String))
            savedObject.setValue(anExperience, forKeyPath: "experience")
            
        } else {
            savedObject.setValue(( experience), forKeyPath: "experience")
        }
        
        
        
        guard let firstName  = user.last?.value(forKeyPath: "firstName") else {
            print("No first name to submit")
            return
        }
        
        savedObject.setValue(firstName,forKeyPath: "firstName")
        
        
        
        
        guard let lastName  = user.last?.value(forKeyPath: "lastName") else {
            print("No last name to submit")
            return
        }
        
        savedObject.setValue(lastName,forKeyPath: "lastName")
        
        
        
        guard let email  = user.last?.value(forKeyPath: "emailAdress") else {
            print("No email to submit")
            return
        }
        
        savedObject.setValue(email,forKeyPath: "emailAdress")
        
        
        
        guard let phoneNumber  = user.last?.value(forKeyPath: "phoneNumber") else {
            print("No phoneNumber to submit")
            return
        }
        
        savedObject.setValue(phoneNumber,forKeyPath: "phoneNumber")
        
        guard let schoolName  = user.last?.value(forKeyPath: "schoolName") else {
            print("No phoneNumber to submit")
            return
        }
        
        savedObject.setValue(schoolName,forKeyPath: "schoolName")
        
        
        
        if( user.last?.value(forKeyPath: "courses") != nil){
            savedObject.setValue(user.last?.value(forKeyPath: "courses") as! String ,forKeyPath: "courses")
        }
        if( user.last?.value(forKeyPath: "skills") != nil){
            savedObject.setValue(user.last?.value(forKeyPath: "skills") as! String ,forKeyPath: "skills")
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
            print("experience Saved!")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
         print(user.count)
    }
    
    
    
    
    
    
    
    
    
    
    func saveCourses(courses: String) {
        
        loadData()
        
        var aCourse = courses
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let locationEntity = NSEntityDescription.entity(forEntityName: "User",
                                                        in: managedContext)!
        //savedObject
        let savedObject = NSManagedObject(entity: locationEntity,
                                          insertInto: managedContext)
        
        
        
        
        
        
        if( user.last?.value(forKeyPath: "courses") != nil){
            aCourse += ("-" + (user.last?.value(forKeyPath: "courses") as! String))
            savedObject.setValue(aCourse, forKeyPath: "courses")
            
        } else {
            savedObject.setValue(( courses), forKeyPath: "courses")
        }
        
        
        
        
        guard let firstName  = user.last?.value(forKeyPath: "firstName") else {
            print("No first name to submit")
            return
        }
        
        savedObject.setValue(firstName,forKeyPath: "firstName")
        
        
        
        
        guard let lastName  = user.last?.value(forKeyPath: "lastName") else {
            print("No last name to submit")
            return
        }
        
        savedObject.setValue(lastName,forKeyPath: "lastName")
        
        
        
        guard let email  = user.last?.value(forKeyPath: "emailAdress") else {
            print("No email to submit")
            return
        }
        
        savedObject.setValue(email,forKeyPath: "emailAdress")
        
        
        
        guard let phoneNumber  = user.last?.value(forKeyPath: "phoneNumber") else {
            print("No phoneNumber to submit")
            return
        }
        
        savedObject.setValue(phoneNumber,forKeyPath: "phoneNumber")
        
        guard let schoolName  = user.last?.value(forKeyPath: "schoolName") else {
            print("No phoneNumber to submit")
            return
        }
        
        savedObject.setValue(schoolName,forKeyPath: "schoolName")
  
        
        /**
        guard let skills  = user.last?.value(forKeyPath: "skills") else {
            print("No phoneNumber to submit")
            return
        }
        
        savedObject.setValue(skills,forKeyPath: "skills")
        */
        
        
        /**
        guard let experience  = user.last?.value(forKeyPath: "experience") else {
            print("No experience to submit")
            return
        }
        */
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
            print("courses Saved!")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
         print(user.count)
    }
    
    
    
    
    
    
    
    
    
    func saveExtracurriculars(extracurricular: String) {
        loadData()
        
        var extracurricularName = extracurricular
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let locationEntity = NSEntityDescription.entity(forEntityName: "User",
                                                        in: managedContext)!
        //savedObject
        let savedObject = NSManagedObject(entity: locationEntity,
                                          insertInto: managedContext)
        
        
        if( user.last?.value(forKeyPath: "extracurriculars") != nil){
            extracurricularName += ("-" + (user.last?.value(forKeyPath: "extracurriculars") as! String))
            savedObject.setValue(extracurricularName, forKeyPath: "extracurriculars")
            
        } else {
            savedObject.setValue(( extracurricular), forKeyPath: "extracurriculars")
        }
        
        
        
        guard let firstName  = user.last?.value(forKeyPath: "firstName") else {
            print("No first name to submit")
            return
        }
        
        savedObject.setValue(firstName,forKeyPath: "firstName")
        
        
        
        
        guard let lastName  = user.last?.value(forKeyPath: "lastName") else {
            print("No last name to submit")
            return
        }
        
        savedObject.setValue(lastName,forKeyPath: "lastName")
        
        
        
        guard let email  = user.last?.value(forKeyPath: "emailAdress") else {
            print("No email to submit")
            return
        }
        
        savedObject.setValue(email,forKeyPath: "emailAdress")
        
        
        
        guard let phoneNumber  = user.last?.value(forKeyPath: "phoneNumber") else {
            print("No phoneNumber to submit")
            return
        }
        
        savedObject.setValue(phoneNumber,forKeyPath: "phoneNumber")
        
        guard let schoolName  = user.last?.value(forKeyPath: "schoolName") else {
            print("No phoneNumber to submit")
            return
        }
        
        savedObject.setValue(schoolName,forKeyPath: "schoolName")
        
        
        
        if( user.last?.value(forKeyPath: "courses") != nil){
            savedObject.setValue(user.last?.value(forKeyPath: "courses") as! String ,forKeyPath: "courses")
        }
        if( user.last?.value(forKeyPath: "skills") != nil){
            savedObject.setValue(user.last?.value(forKeyPath: "skills") as! String ,forKeyPath: "skills")
        }
        if( user.last?.value(forKeyPath: "experience") != nil){
            savedObject.setValue(user.last?.value(forKeyPath: "experience") as! String ,forKeyPath: "experience")
        }
        if( user.last?.value(forKeyPath: "objective") != nil){
            savedObject.setValue(user.last?.value(forKeyPath: "objective") as! String ,forKeyPath: "objective")
        }
        
        
        
        
        let userRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do {
            try managedContext.save()
            user = try managedContext.fetch(userRequest)
            
            user.append(savedObject)
            print("Award Saved!")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        print(user.count)
    }
    
    
    func saveObjective(statement: String) {
        loadData()
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let locationEntity = NSEntityDescription.entity(forEntityName: "User",
                                                        in: managedContext)!
        //savedObject
        let savedObject = NSManagedObject(entity: locationEntity,
                                          insertInto: managedContext)
        
        
        savedObject.setValue(statement,forKeyPath: "objective")
        
        
        
        guard let firstName  = user.last?.value(forKeyPath: "firstName") else {
            print("No first name to submit")
            return
        }
        savedObject.setValue(firstName,forKeyPath: "firstName")
        
        guard let lastName  = user.last?.value(forKeyPath: "lastName") else {
            print("No last name to submit")
            return
        }
        savedObject.setValue(lastName,forKeyPath: "lastName")
        
        guard let email  = user.last?.value(forKeyPath: "emailAdress") else {
            print("No email to submit")
            return
        }
        savedObject.setValue(email,forKeyPath: "emailAdress")
        
        guard let phoneNumber  = user.last?.value(forKeyPath: "phoneNumber") else {
            print("No phoneNumber to submit")
            return
        }
        savedObject.setValue(phoneNumber,forKeyPath: "phoneNumber")
        
        guard let schoolName  = user.last?.value(forKeyPath: "schoolName") else {
            print("No phoneNumber to submit")
            return
        }
        savedObject.setValue(schoolName,forKeyPath: "schoolName")
        
       
        
        
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
        
        
        
        
        let userRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do {
            try managedContext.save()
            user = try managedContext.fetch(userRequest)
            
            user.append(savedObject)
            print("Award Saved!")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        print(user.count)
    }
    
    
    
    
    func loadData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        //let timeRequest = NSFetchRequest<NSManagedObject>(entityName: "Time")
        do {
            user = try managedContext.fetch(userRequest)
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
        
        
    }
    
    
    
    
}
