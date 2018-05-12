//
//  newDataManager.swift
//  resumeToolkit
//
//  Created by Arya Mirshafii on 5/1/18.
//  Copyright © 2018 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import CoreData
class newDataManager{
    private var courses:[course]!
    private var experiences:[experience]!
    private var extracurriculars:[extracurricular]!
    private var skills:[skill]!
    private var theUser: user!
    private var context:NSManagedObjectContext!
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        
        if #available(iOS 10.0, *) {
            self.context = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            self.context = appDelegate.managedObjectContext
        }
        loadUser()
    }
    func savefirstName(firstName:String){
        loadUser()
        
        
        do {
            
            theUser.setValue(firstName, forKey: "firstName")
            try context.save()
            
        }catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    
    
    func saveLastName(lastName:String){
        loadUser()
        
        
        do {
            
            theUser.setValue(lastName, forKey: "lastName")
            try context.save()
            
        }catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    func saveEmail(emailAddress:String){
        loadUser()
        
        
        do {
            
            theUser.setValue(emailAddress, forKey: "emailAddress")
            try context.save()
            
        }catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    
    
    
    
    
    func savePhoneNumber(phoneNumber:String){
        loadUser()
        
        
        do {
            
            theUser.setValue(phoneNumber, forKey: "phoneNumber")
            try context.save()
            
        }catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    
    
    func saveSchool(schoolName:String){
        loadUser()
       
        
        do {
            
            theUser.setValue(schoolName, forKey: "schoolName")
            try context.save()
            
        }catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    
    
    func saveObjective(objective:String){
        loadUser()
        do {
        
        
            
            theUser.setValue(objective, forKey: "objective")
            try context.save()
            
        }catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    
    
    func overwriteSkill(name:String,updatedDescription: String){
        getSkills()
        var skillToUpdate:skill!
        for aSkill in skills{
            if(aSkill.name == name) {
                skillToUpdate = aSkill
                break
            }
        }
        if(skillToUpdate != nil){
            
            
            do {
                
                skillToUpdate.setValue(updatedDescription, forKey: "skillDescription")
                try context.save()
                print("Updating skill")
            }catch let error as NSError {
                // failure
                print("Fetch failed: \(error.localizedDescription)")
            }
        } else {
            print("The requested item cannot be found")
        }
    }
    
    
    
    
    
    
    func deleteSkill(name:String){
        getSkills()
        var skillToDelete:skill!
        for aSkill in skills{
            if(aSkill.name == name) {
                skillToDelete = aSkill
                break
            }
        }
        if(skillToDelete != nil){
            
            
            do {
                
                context.delete(skillToDelete)
                try context.save()
                print("Updating skill")
            }catch let error as NSError {
                // failure
                print("Fetch failed: \(error.localizedDescription)")
            }
        } else {
            print("The requested item cannot be found")
        }
    }
    
    
    
    
    
    
    func overWriteExtracurricular(name:String, updatedDescription: String, updatedYear:String){
        getExtracurriculars()
        var ecToUpdate:extracurricular!
        for anEC in extracurriculars{
            if(anEC.name == name) {
                ecToUpdate = anEC
                break
            }
        }
        if(ecToUpdate != nil){
            
            
            do {
                
                ecToUpdate.editName(newName: name)
                ecToUpdate.editDescription(newDescription: updatedDescription)
                ecToUpdate.editYear(newYear: updatedYear)
                try context.save()
                
            }catch let error as NSError {
                // failure
                print("Fetch failed: \(error.localizedDescription)")
            }
        } else {
            print("The requested item cannot be found")
        }
    }
    
    
    
    
    
    
    func deleteExtraCurricular(name:String){
        getExtracurriculars()
        var ecToDelete:extracurricular!
        for anEC in extracurriculars{
            if(anEC.name == name) {
                ecToDelete = anEC
                break
            }
        }
        if(ecToDelete != nil){
            
            
            
            do {
                
                context.delete(ecToDelete)
                try context.save()
                
            }catch let error as NSError {
                // failure
                print("Fetch failed: \(error.localizedDescription)")
            }
        } else {
            print("The requested item cannot be found")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func overwriteCourses(name:String, updatedDescription: String){
        getCourses()
        var courseToUpdate:course!
        for aCourse in courses{
            if(aCourse.name == name) {
                courseToUpdate = aCourse
                break
            }
        }
        if(courseToUpdate != nil){
            
            
            do {
                
                courseToUpdate.editName(newName: name)
                courseToUpdate.editDescription(newDescription: updatedDescription)
               
                try context.save()
                
            }catch let error as NSError {
                // failure
                print("Fetch failed: \(error.localizedDescription)")
            }
        } else {
            print("The requested item cannot be found")
        }
    }
    
    
    
    
    
    
    func deleteCourse(name:String){
        getCourses()
        var courseToDelete:course!
        for aCourse in courses{
            if(aCourse.name == name) {
                courseToDelete = aCourse
                break
            }
        }
        if(courseToDelete != nil){
            
            
            do {
                
                context.delete(courseToDelete)
                try context.save()
                
            }catch let error as NSError {
                // failure
                print("Fetch failed: \(error.localizedDescription)")
            }
        } else {
            print("The requested item cannot be found")
        }
    }
    
    
    
    
    func overWriteExperiences(yearStarted: String, yearEnded: String, companyName: String, companyDescription:String,
                              name: String, objectContext: NSManagedObjectContext!){
        getExperiences()
        var experienceToUpdate:experience!
        for anExperience in experiences{
            if(anExperience.name == name) {
                experienceToUpdate = anExperience
                break
            }
        }
        if(experienceToUpdate != nil){
           
            do {
                
                experienceToUpdate.editStartYear(newStartyear: yearStarted)
                experienceToUpdate.editEndYear(newEndYear: yearEnded)
                experienceToUpdate.editCompanyName(newCompany: companyName)
                experienceToUpdate.editDescription(newDescription: companyDescription)
                experienceToUpdate.editName(newName: name)
                
                try context.save()
                
            }catch let error as NSError {
                // failure
                print("Fetch failed: \(error.localizedDescription)")
            }
        } else {
            print("The requested item cannot be found")
        }
    }
    
    
    
    
    func deleteExperience(name:String){
        getExperiences()
        var experienceToDelete:experience!
        for anExperience in experiences{
            if(anExperience.name == name) {
                experienceToDelete = anExperience
                break
            }
        }
        if(experienceToDelete != nil){
            
            do {
                
                context.delete(experienceToDelete)
                try context.save()
                
            }catch let error as NSError {
                // failure
                print("Fetch failed: \(error.localizedDescription)")
            }
        } else {
            print("The requested item cannot be found")
        }
    }
    
    
    
    
    
    func getCourses(){
        let courseFetch: NSFetchRequest<course> = course.fetchRequest() as! NSFetchRequest<course>
        do {
            courses = try context.fetch(courseFetch)
        } catch {
            fatalError("Failed to fetch course: \(error)")
        }
    }
    
    func getExperiences(){
        
        
        let experienceFetch: NSFetchRequest<experience> = experience.fetchRequest() as! NSFetchRequest<experience>
        do {
            experiences = try context.fetch(experienceFetch)
        } catch {
            fatalError("Failed to fetch experience: \(error)")
        }
    }
    
    func getSkills(){
        let skillFetch: NSFetchRequest<skill> = skill.fetchRequest() as! NSFetchRequest<skill>
        do {
            skills = try context.fetch(skillFetch)
        } catch {
            fatalError("Failed to fetch skill: \(error)")
        }
    }
    
    
    func getExtracurriculars(){
        let extracurricularFetch: NSFetchRequest<extracurricular> = extracurricular.fetchRequest() as! NSFetchRequest<extracurricular>
        do {
            extracurriculars = try context.fetch(extracurricularFetch)
        } catch {
            fatalError("Failed to fetch extracurricular: \(error)")
        }
    }
    
    
    
    func getContext() -> NSManagedObjectContext{
        return context
    }
    
    func fetchExperiences()->[experience] {
        getExperiences()
        return experiences
    }
    
    func fetchSkills()->[skill] {
        getSkills()
        return skills
    }
    
    
    
    func fetchCourses()->[course] {
        getCourses()
        return courses
    }
    
    func fetchExtraCurriculars()->[extracurricular] {
        getExtracurriculars()
        return extracurriculars
    }
    
    
    
    
    
    
    
    
    private func loadUser(){
        let fetchUser: NSFetchRequest<user> = user.fetchRequest() as! NSFetchRequest<user>
        do {
            let data  = try context.fetch(fetchUser)
            if(data.isEmpty) {
                print("Crashing" )
                theUser = user(emailAdress: "", firstName: "", gradeLevel: "", lastName: "", objective: "", phoneNumber: "", schoolName: "",objectContext: context)
            } else {
                theUser = data.last
            }
            
        } catch {
            fatalError("Failed to fetch user: \(error)")
        }
    }
    
    func getUser() -> user{
        return theUser
    }
}
