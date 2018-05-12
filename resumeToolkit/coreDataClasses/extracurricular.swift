//
//  extracurricular.swift
//  resumeWriterPro
//
//  Created by Arya Mirshafii on 1/1/18.
//  Copyright © 2018 georgiaTechEngineeringForInnovationGroup. All rights reserved.
//

import UIKit
import CoreData

@objc(extracurricular)


class extracurricular:NSManagedObject {
    private var context:NSManagedObjectContext!
    @NSManaged  var name: String
    @NSManaged  var ecDescription: String
    @NSManaged  var year: String
    
    convenience init(name: String, ecDescription: String,  year: String,objectContext: NSManagedObjectContext!) {
        
        
        
        
        
        let entity = NSEntityDescription.entity(forEntityName: "Extracurricular", in: objectContext)!
        self.init(entity: entity, insertInto: objectContext)
        self.name = name
        self.context = objectContext
        self.ecDescription = ecDescription
        self.year = year
        
        
        save()
        
        
    }
    
    func editName(newName:String) {
        self.name = newName
        save()
    }
    
    
    func editDescription(newDescription:String) {
        self.ecDescription = newDescription
        save()
    }
    
    func editYear(newYear:String) {
        self.year = newYear
        save()
    }
    
    
    func delete() {
        
        context.delete(self)
        
    }
    
    private func save(){
        do {
            try context.save()
            
        } catch {
            fatalError("Failure to save skill: \(error)")
        }
    }
}
