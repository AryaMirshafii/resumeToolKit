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
        user.removeAll()
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
        for aUser in user{
            var printvalue = aUser.value(forKeyPath: "firstName") as? String
            print("*************" + printvalue!)
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //saves first name of user
    func savefirstName(firstName: String) {
        
    
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
            user.removeAll()
            user.append(savedObject)
            print("it savd")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    func saveEmail(email: String) {
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
        if((user[user.count - 1].value(forKeyPath: "firstName") as? String) != nil){
            savedObject.setValue((user[user.count - 1].value(forKeyPath: "firstName") as? String), forKeyPath: "emailAdress")
        }
        
        do {
            try managedContext.save()
            user.append(savedObject)
            print((user[user.count].value(forKeyPath: "emailAdress") as? String))
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
    
    
    
    
    
}
