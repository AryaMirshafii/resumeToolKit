//
//  testPDFGenerator.swift
//  Print2PDF
//
//  Created by arya mirshafii on 9/7/17.
//  Copyright © 2017 Appcoda. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class testPDFGenerator {
    var pdfFilePath = " "
    var user: [NSManagedObject] = []
    init() {
        loadData()
        //self.pdfFilePath = createPDFFileAndReturnPath()
        
    }
    
    
    
    func createPDFFileAndReturnPath() -> String {
        
        let fileName = "pdffilename.pdf"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0] as NSString
        let pathForPDF = documentsDirectory.appending("/" + fileName)
        
        
        
        let text =  getText()
        
        
        
        let A4paperSize = CGSize(width: 2771, height: 3586)
        let pdf = SimplePDF(pageSize: A4paperSize)
        let font = UIFont(name: "Helvetica Bold", size: 60.0)
        
        
        
        pdf.setFont( font! )
        pdf.addText(text)
        
        
        let pdfData = pdf.generatePDFdata()
        
        // save as a local file
        
        
        try? pdfData.write(to: URL(fileURLWithPath: pathForPDF), options: .atomic)
        
        
        
        return pathForPDF
    }
    
    
    
    
    func getText() -> String{
        loadData()
        let aUser = user.last
        
        
        
        guard let firstName  = aUser?.value(forKeyPath: "firstName") as? String  else {
            //print("nothing to see here")
            return ""
            
            
            
            
        }
        //var lastname = aUser.value(forKeyPath: "lastName") as? String
        guard let lastName  = aUser?.value(forKeyPath: "lastName") as? String  else {
            //print("nothing to see here")
            return ""
            
            
            
            
        }
        
        
        guard let email  = aUser?.value(forKeyPath: "emailAdress") as? String  else {
            //print("nothing to see here")
            return ""
            
            
            
            
        }
        
        guard let phoneNumber  = aUser?.value(forKeyPath: "phoneNumber") as? String  else {
            //print("nothing to see here")
            return ""
            
            
            
            
        }
        
        
        
        
        
        
        guard let schoolName  = aUser?.value(forKeyPath: "schoolName") as? String  else {
            //print("nothing to see here")
            return ""
        }
        
        
        guard let gradeLevel  = aUser?.value(forKeyPath: "gradeLevel") as? String  else {
            //print("nothing to see here")
            return ""
        }
        
        
        
        /**
        let multiLineTemplate = """
        Line: \(firstName)
        Line: \(lastName)
        Line: \(email)
        Line: \(phoneNumber)
        Line: \(schoolName)
        Line: \(gradeLevel)
        
        """
        */
        //let secondline = NSString(firstName + " " + lastName) + "\n" + email  + "\n" + phoneNumber + "\n" + schoolName + "\n" + gradeLevel)
       
        let secondline = ( ("\(firstName) \(lastName) \n\(email)") + " \n\(phoneNumber)\n\(schoolName)\n\(gradeLevel)")
        //let aLine = [firstName,lastName,email,phoneNumber,schoolName,gradeLevel]
        
        return secondline
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