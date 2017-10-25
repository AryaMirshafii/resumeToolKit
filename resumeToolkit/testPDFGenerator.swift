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
import GoogleAPIClientForREST
import GoogleSignIn


class testPDFGenerator {
    let service = GTLRDriveService()
    var pdfFilePath = " "
    var informationController = userInfo()
    var user: [NSManagedObject] = []
    var skills:String! = " "
    var professionalDevelopment:String! = " "
    var courses:String! = " "
    var awards:String! = " "
    init() {
        loadData()
        //self.createPDFFileAndReturnPath()
        //self.saveAsPDF()
        
    }
    
    
    /**
    func createPDFFileAndReturnPath() -> String {
        /**
        let fileName = "pdffilename.pdf"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0] as NSString
        let pathForPDF = documentsDirectory.appending("/" + fileName)
        */
        
        
        let text =  getText()
        
        
        
        
        
        
        let pdfData = pdf.generatePDFdata()
        
        
        
        return pathForPDF
    }
    */
    
    
    
    
    var html = ""
    func createPDFFileAndReturnPath() -> (html: String, output: String){
        var htmlFile = Bundle.main.path(forResource: "resume1", ofType: "html")
        html = try! String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8)
        //let html = "<b>Hello <i>World!</i></b>"
        
        
        //ADDS DATA TO PDF VERY IMPORTANT
        html = addDataToPDF(oldHTML: html)
        //html = "<b>Hello <i>World!</i></b>"
        let fmt = UIMarkupTextPrintFormatter(markupText: html)
        
        // 2. Assign print formatter to UIPrintPageRenderer
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAt: 0)
        
        // 3. Assign paperRect and printableRect
        //let A4paperSize = CGSize(width: 2771, height: 3586)
        //let page = CGRect(x: 0, y: 0, width: 2771, height: 3586)
        let page = CGRect(x: 0, y: 0, width: 2771, height: 3586)
        let printable = page.insetBy(dx: 0, dy: 0)
        render.setValue(page, forKey: "paperRect")
        render.setValue(printable, forKey: "printableRect")
        
        // 4. Create PDF context and draw
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
        
        for i in 0..<render.numberOfPages {
            UIGraphicsBeginPDFPage();
            render.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
        
        UIGraphicsEndPDFContext();
        
        
        // 5. Save PDF file
        //guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("output").appendingPathExtension("pdf")
            //else { fatalError("Destination URL not created") }
        
        
        let fileName = "pdffilename.pdf"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0] as! NSString
        let outputURL = documentsDirectory.appending("/" + fileName)
        //let outputURL = URL()
        
        //URL(fileURLWithPath: <#T##String#>)
        
        let newData = pdfData.copy() as! NSData
        
        newData.write(to: URL(fileURLWithPath: outputURL), atomically: true)
        print("DATA")
        print(newData)
        
        print("open \(outputURL)")
        print("ARYA ME" + String(describing: outputURL))
        
        //webView.loadHTMLString(html!, baseURL: outputURL)
     
    return (html, outputURL)
        
       
        
    }
    
    /**
    func saveAsPDF(){
        let sixzevid = CGSize(width: 2771, height: 3586)
        
        UIGraphicsBeginImageContext(sixzevid);
        
        webView.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        var imageData = NSData()
        
        imageData = UIImagePNGRepresentation(viewImage!)! as NSData
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        let pathFolder = String(String(format:"%@", "new.png"))
        
        let defaultDBPathURL = NSURL(fileURLWithPath: documentsPath).appendingPathComponent(pathFolder)
        
        let defaultDBPath = "\(defaultDBPathURL)"
        
        
        let url = NSURL(fileURLWithPath: defaultDBPath)
        let urlRequest = NSURLRequest(url: url as URL)
        
        
        
        
    }
 */
    
    var newHTML = " "
    func addDataToPDF(oldHTML: String) ->String {
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
        
        
        
        
        
        skills = aUser?.value(forKeyPath: "skills") as? String
        
        professionalDevelopment  = aUser?.value(forKeyPath: "experience") as? String
        courses = aUser?.value(forKeyPath: "courses") as? String
        awards = aUser?.value(forKeyPath: "awards") as? String
        
        
        
        //Replace Name
        
        //let phoneNumber
        
        newHTML = oldHTML.replacingOccurrences(of: "YourNameHere", with: firstName + " " + lastName)
        newHTML = newHTML.replacingOccurrences(of: "YourPhoneNumberHere", with: "Phone Number: " + phoneNumber)
        newHTML = newHTML.replacingOccurrences(of: "YourEmailHere", with: "Email: " + email)
        
        
        
        
        
        let skillSring = "Skill_Science_Using scientific rules and methods to solve problems.-Skill_Critical Thinking_Using logic and reasoning to identify the strengths and weaknesses of alternative solutions, conclusions or whatever.-Skill_Being Handsome_Being SO good looking."
        
        if(skills != nil){
            var skillArr = skills.components(separatedBy:"-")
            
            var skillHTML = ""
            for aSkill in skillArr{
                let skillDescription = aSkill.components(separatedBy:"_")
                
                skillHTML += (String(format: "<dt>%@</dt><dd>%@</dd>", skillDescription[1],skillDescription[2]))
                
            }
            newHTML = newHTML.replacingOccurrences(of: "SkillsGoHere", with: skillHTML)
        }
        
        
        
        
        // PROFESSIONAL DEVELOPMENT LOADED
        if(professionalDevelopment != nil){
            var experienceArr = professionalDevelopment.components(separatedBy:"-")
            
            var experienceHTML = ""
            for anExperience in experienceArr{
                let experienceDescription = anExperience.components(separatedBy:"_")
                print(experienceDescription)
                experienceHTML += (String(format: "<dt>%@</dt><dd>%@</dd>", experienceDescription[1] + "                   " + experienceDescription[2] + "to" +   experienceDescription[3] , experienceDescription[4] + "-" + experienceDescription[6]))
                
            }
            newHTML = newHTML.replacingOccurrences(of: "ExperienceGoHere", with: experienceHTML)
            
        }
       
        
        
        
        //STUFF FOR AWARDS
        if(awards != nil){
            var awardsArr = awards.components(separatedBy:"-")
            
            var awardHTML = ""
            for anAward in awardsArr{
                let awardDescription = anAward.components(separatedBy:"_")
                
                awardHTML += (String(format: "<dt>%@</dt><dd>%@</dd>", awardDescription[1],awardDescription[2]))
                
            }
            newHTML = newHTML.replacingOccurrences(of: "AwardsGoHere", with: awardHTML)
        }
       
        
        
        if(courses != nil){
            var coursesArr = courses.components(separatedBy:"-")
            
            var courseHTML = ""
            for aCourse in coursesArr{
                let courseDescription = aCourse.components(separatedBy:"_")
                
                courseHTML += (String(format: "<dt>%@</dt><dd>%@</dd>", courseDescription[1],courseDescription[2]))
                
            }
            newHTML = newHTML.replacingOccurrences(of: "CoursesGoHere", with: courseHTML)
        }
        
        
        
        
        return newHTML
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
        
        
        
        
       
        skills = aUser?.value(forKeyPath: "skills") as? String
        
        professionalDevelopment  = aUser?.value(forKeyPath: "experience") as? String
        courses = aUser?.value(forKeyPath: "courses") as? String
        awards = aUser?.value(forKeyPath: "awards") as? String
        
        let gradeLevel = ""
        let secondline = ( ("\(firstName) \(lastName) \n\(email)") + " \n\(phoneNumber)\n\(schoolName)\n\(gradeLevel)\n\("SKILLS")\n\(loadEntryItems(anEntry: skills))\n\("PROFESSIONAL DEVELOPMENT")\n\(loadEntryItems(anEntry: professionalDevelopment))\n\("COURSES TAKEN")\n\(loadEntryItems(anEntry: courses))\n\("AWARDS")\n\(loadEntryItems(anEntry: awards))")
        //let entryItems = loadEntryItems()
        
       
        //print("the first thing is" + EntryItems[0])
        
        return secondline
    }
    var restultantString = " "
    func loadEntryItems(anEntry: String?) -> String{
        restultantString = " "
        if let testVar = anEntry{
            
        } else {
            return " "
        }
        var separatedArr = anEntry?.components(separatedBy:"_")
        for index in 1...((separatedArr?.count)!-1){
            restultantString += "\n" + String(repeating: " ", count: index) + separatedArr![index]
        }
        
        return restultantString
    }
    //func separateInto
    
    
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
