//
//  skill.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/7/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import CoreData
import UIKit


@objc(skill)
class skill: NSManagedObject {
    private var context:NSManagedObjectContext!
    @NSManaged  var name: String
    @NSManaged  var skillDescription: String
    
    convenience init(name: String, description: String, objectContext: NSManagedObjectContext!) {
        
       
        
        
        
        let entity = NSEntityDescription.entity(forEntityName: "Skill", in: objectContext)!
        self.init(entity: entity, insertInto: objectContext)
        self.context = objectContext
        self.name = name
        self.skillDescription = description
       
        
        save()
        
        
    }
    
    
    
    func editName(newName:String) {
        self.name = newName
        save()
    }
    
    
    func editDescription(newDescription:String) {
        self.skillDescription = newDescription
        save()
    }
    
    
    
    private func save(){
        do {
            try context.save()
            
        } catch {
            fatalError("Failure to save skill: \(error)")
        }
    }
}
