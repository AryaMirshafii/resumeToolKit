//
//  User+CoreDataProperties.swift
//  
//
//  Created by arya mirshafii on 11/25/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var courses: String?
    @NSManaged public var emailAdress: String?
    @NSManaged public var experience: String?
    @NSManaged public var extracurriculars: String?
    @NSManaged public var firstName: String?
    @NSManaged public var gradeLevel: String?
    @NSManaged public var lastName: String?
    @NSManaged public var objective: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var schoolName: String?
    @NSManaged public var skills: String?

}
