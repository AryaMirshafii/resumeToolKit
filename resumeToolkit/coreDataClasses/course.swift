//
//  course.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/15/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(course)
class course: NSManagedObject {
    
    @NSManaged   var name: String
    @NSManaged  var courseDescription: String
    
    private var context:NSManagedObjectContext!
    
    
    
    
    
    
    convenience init(name: String, courseDescription: String, objectContext: NSManagedObjectContext!) {
        
        
        
        let entity = NSEntityDescription.entity(forEntityName: "Course", in: objectContext)!
        
        self.init(entity: entity, insertInto: objectContext)
        self.context = objectContext
        self.name = name
        self.courseDescription = courseDescription
       
        
        
        self.save()
        
       
    }
    
    func editName(newName:String) {
        self.name = newName
        save()
    }
    
    
    func editDescription(newDescription:String) {
        self.courseDescription = newDescription
        save()
    }
    
    
    
    func delete() {
        
        context.delete(self)
        
    }
    
    private func save(){
        do {
            try context.save()
            
        } catch {
            fatalError("Failure to save course: \(error)")
        }
    }
    
}
