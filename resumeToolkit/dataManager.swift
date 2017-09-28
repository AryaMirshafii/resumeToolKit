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
        
        self.printStuff()
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
    
    
    
    func checkInfoComplete() -> Bool {
        let aUser = user.last
        
        
        
        guard let firstName  = aUser?.value(forKeyPath: "firstName") as? String  else {
            //print("nothing to see here")
            return false
            
            
            
            
        }
        //var lastname = aUser.value(forKeyPath: "lastName") as? String
        guard let lastname  = aUser?.value(forKeyPath: "lastName") as? String  else {
            //print("nothing to see here")
            return false
            
            
            
            
        }
        
        
        guard let email  = aUser?.value(forKeyPath: "emailAdress") as? String  else {
            //print("nothing to see here")
            return false
            
            
            
            
        }
        
        guard let phoneNumber  = aUser?.value(forKeyPath: "phoneNumber") as? String  else {
            //print("nothing to see here")
            return false
            
            
            
            
        }
        
        
        
        
        
        
        guard let schoolName  = aUser?.value(forKeyPath: "schoolName") as? String  else {
            //print("nothing to see here")
            return false
        }
        
        
        guard let gradeLevel  = aUser?.value(forKeyPath: "gradeLevel") as? String  else {
            //print("nothing to see here")
            return false
        }
        
        
        //ininfoController.save(screen: "main")
        return true
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
    
    
    
    func saveGradeLevel(gradeLevel: String) {
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
        
        savedObject.setValue(gradeLevel, forKeyPath: "gradeLevel")
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
        
        
        let userRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do {
            try managedContext.save()
            user = try managedContext.fetch(userRequest)
            
            user.append(savedObject)
            print("grade level Saved!")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    
    
    func saveSkills(skills: String) {
        
        loadData()
        var aSkill = skills
        
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
            savedObject.setValue(( skills), forKeyPath: "skills")
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
        
        guard let gradeLevel  = user.last?.value(forKeyPath: "gradeLevel") else {
            print("No phoneNumber to submit")
            return
        }
        
        savedObject.setValue(gradeLevel,forKeyPath: "gradeLevel")
        
        if( user.last?.value(forKeyPath: "courses") != nil){
            savedObject.setValue(user.last?.value(forKeyPath: "courses") as! String ,forKeyPath: "courses")
        }
        if( user.last?.value(forKeyPath: "experience") != nil){
            savedObject.setValue(user.last?.value(forKeyPath: "experience") as! String ,forKeyPath: "experience")
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
        guard let gradeLevel  = user.last?.value(forKeyPath: "gradeLevel") else {
            print("No phoneNumber to submit")
            return
        }
        
        savedObject.setValue(gradeLevel,forKeyPath: "gradeLevel")
        
        
        if( user.last?.value(forKeyPath: "courses") != nil){
            savedObject.setValue(user.last?.value(forKeyPath: "courses") as! String ,forKeyPath: "courses")
        }
        if( user.last?.value(forKeyPath: "skills") != nil){
            savedObject.setValue(user.last?.value(forKeyPath: "skills") as! String ,forKeyPath: "skills")
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
        guard let gradeLevel  = user.last?.value(forKeyPath: "gradeLevel") else {
            print("No phoneNumber to submit")
            return
        }
        
        savedObject.setValue(gradeLevel,forKeyPath: "gradeLevel")
        
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
        
        
        
        
        
        let userRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do {
            try managedContext.save()
            user = try managedContext.fetch(userRequest)
            
            user.append(savedObject)
            print("courses Saved!")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    
    
    
    
    
    
    func saveAwards(awardName: String) {
        loadData()
        
        var anAwardName = awardName
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let locationEntity = NSEntityDescription.entity(forEntityName: "User",
                                                        in: managedContext)!
        //savedObject
        let savedObject = NSManagedObject(entity: locationEntity,
                                          insertInto: managedContext)
        
        
        if( user.last?.value(forKeyPath: "awards") != nil){
            anAwardName += ("-" + (user.last?.value(forKeyPath: "awards") as! String))
            savedObject.setValue(anAwardName, forKeyPath: "awards")
            
        } else {
            savedObject.setValue(( awardName), forKeyPath: "awards")
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
        guard let gradeLevel  = user.last?.value(forKeyPath: "gradeLevel") else {
            print("No phoneNumber to submit")
            return
        }
        
        savedObject.setValue(gradeLevel,forKeyPath: "gradeLevel")
        
        
        if( user.last?.value(forKeyPath: "courses") != nil){
            savedObject.setValue(user.last?.value(forKeyPath: "courses") as! String ,forKeyPath: "courses")
        }
        if( user.last?.value(forKeyPath: "skills") != nil){
            savedObject.setValue(user.last?.value(forKeyPath: "skills") as! String ,forKeyPath: "skills")
        }
        if( user.last?.value(forKeyPath: "experience") != nil){
            savedObject.setValue(user.last?.value(forKeyPath: "experience") as! String ,forKeyPath: "experience")
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
