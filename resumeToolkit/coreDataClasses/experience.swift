//
//  experience.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/7/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import CoreData
import UIKit


@objc(experience)
class experience: NSManagedObject{
    
    @NSManaged    var yearStarted: String
    @NSManaged   var yearEnded: String
    @NSManaged   var companyName: String
    @NSManaged   var companyDescription:String
    @NSManaged   var name: String
    private var context:NSManagedObjectContext!

    
    
    
   
    
    convenience init(yearStarted: String, yearEnded: String, companyName: String, companyDescription:String,
                     name: String, objectContext: NSManagedObjectContext!) {
        
        
        
        
        
        let entity = NSEntityDescription.entity(forEntityName: "Experience", in: objectContext)!
        self.init(entity: entity, insertInto: objectContext)
        self.context = objectContext
        self.yearStarted = yearStarted
        self.yearEnded = yearEnded
        self.companyName = companyName
        self.companyDescription = companyDescription
        self.name = name
        
        
        save()
        
        
    }
    
    func editStartYear(newStartyear:String) {
        self.yearStarted = newStartyear
        save()
    }
    
    
    func editEndYear(newEndYear:String) {
        self.yearEnded = newEndYear
        save()
    }
    
    func editCompanyName(newCompany:String) {
        self.companyName = newCompany
        save()
    }
    
    func editDescription(newDescription:String) {
        self.companyDescription = newDescription
        save()
    }
    
    func editName(newName:String) {
        self.name = newName
        save()
    }
    
    func delete() {
        
        context.delete(self)
        
    }
    
   
    
    private func save(){
        do {
            try context.save()
            
        } catch {
            fatalError("Failure to save experience: \(error)")
        }
    }

        
}
