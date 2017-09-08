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
        self.pdfFilePath = createPDFFileAndReturnPath()
        
    }
    
    
    
    func createPDFFileAndReturnPath() -> String {
        loadData()
        let fileName = "pdffilename.pdf"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0] as! NSString
        let pathForPDF = documentsDirectory.appending("/" + fileName)
        
        UIGraphicsBeginPDFContextToFile(pathForPDF, CGRect.zero, nil)
        
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: 2771, height: 3586), nil)
        
        
        
        let font = UIFont(name: "Helvetica Bold", size: 60.0)
       
        let textRect = CGRect(x: 5, y: 3, width: 2766, height: 3583)
        var paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.alignment = NSTextAlignment.left
        paragraphStyle.lineBreakMode = NSLineBreakMode.byTruncatingHead
        
        let textColor = UIColor.black
        
        let textFontAttributes = [
            NSAttributedStringKey.font: font!,
            NSAttributedStringKey.foregroundColor: textColor,
            NSAttributedStringKey.paragraphStyle: paragraphStyle
        ]
        
        let text:NSString = getText()
        
        text.draw(in: textRect, withAttributes: textFontAttributes)
        
        UIGraphicsEndPDFContext()
        
        return pathForPDF
    }
    
    
    
    
    func getText() -> NSString{
        let aUser = user.last
        
        
        
        guard let firstName  = aUser?.value(forKeyPath: "firstName") as? String  else {
            //print("nothing to see here")
            return""
            
            
            
            
        }
        //var lastname = aUser.value(forKeyPath: "lastName") as? String
        guard let lastName  = aUser?.value(forKeyPath: "lastName") as? String  else {
            //print("nothing to see here")
            return""
            
            
            
            
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
            return""
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
        let secondline = (firstName + " " + lastName) + "\n" + email  + "\n" + phoneNumber + "\n" + schoolName + "\n" + gradeLevel
       
        
        return secondline as NSString
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
