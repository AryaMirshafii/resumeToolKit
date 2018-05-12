//
//  user.swift
//  resumeToolkit
//
//  Created by Arya Mirshafii on 5/1/18.
//  Copyright © 2018 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import CoreData
import UIKit
@objc(user)
class user: NSManagedObject{
    @NSManaged  var emailAddress: String
    @NSManaged  var firstName: String
    @NSManaged  var gradeLevel: String
    @NSManaged  var lastName: String
    @NSManaged  var objective: String
    @NSManaged  var phoneNumber: String
    @NSManaged  var schoolName: String
    private var context:NSManagedObjectContext!
    
    
    
    convenience init(emailAdress: String, firstName: String, gradeLevel: String, lastName: String,
        objective: String, phoneNumber: String, schoolName: String, objectContext: NSManagedObjectContext!) {
       
        let entity = NSEntityDescription.entity(forEntityName: "User", in: objectContext)!
        self.init(entity: entity, insertInto: objectContext)
        
        
        
        self.emailAddress = emailAdress
        self.firstName = firstName
        self.gradeLevel = gradeLevel
        self.lastName = objective
        self.objective = objective
        self.phoneNumber = phoneNumber
        self.schoolName = schoolName
        self.context = objectContext
        
        
       
        
        save()
        
        
    }
    
    func delete() {
        
        context.delete(self)
        
    }
    
    func editFirstName(firstName:String) {
        self.firstName = firstName
        save()
    }
    
    func editLastName(lastName:String) {
        self.lastName = lastName
        save()
    }
    
    func editEmail(email:String) {
        self.emailAddress = email
        save()
    }
    
    func editPhoneNumber(thePhoneNumber:String) {
        self.phoneNumber = thePhoneNumber
        save()
    }
    
    
    func editSchoolName(schoolName:String) {
        self.schoolName = schoolName
        save()
    }
    
    
    
    private func save(){
        do {
            try context.save()
            
        } catch {
            fatalError("Failure to save user: \(error)")
        }
    }
}
