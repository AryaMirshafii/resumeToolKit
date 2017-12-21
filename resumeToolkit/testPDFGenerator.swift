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
    var extracurriculars:String! = " "
    var objective:String! = " "
    var resumeIndex = 1
    init() {
        loadData()
       
        
    }
    
    
    
    
    var reloadCounter = 0
    var html = ""
    func createPDFFileAndReturnPath(indexAt:String) -> (html: String, output: String){
        var htmlFile = ""
        if(indexAt == "0"){
            htmlFile = Bundle.main.path(forResource: "resume1", ofType: "html")!
            html = try! String(contentsOfFile: htmlFile, encoding: String.Encoding.utf8)
            
            //ADDS DATA TO PDF VERY IMPORTANT
            html = addDataToPDF(oldHTML: html,resumeNumber: "resume1")
            
        } else if(indexAt == "1"){
            htmlFile = Bundle.main.path(forResource: "resume2", ofType: "html")!
            html = try! String(contentsOfFile: htmlFile, encoding: String.Encoding.utf8)
            
            //ADDS DATA TO PDF VERY IMPORTANT
            html = addDataToPDF(oldHTML: html,resumeNumber: "resume2")
            
        } else if(indexAt == "2") {
            htmlFile = Bundle.main.path(forResource: "resume3", ofType: "html")!
            html = try! String(contentsOfFile: htmlFile, encoding: String.Encoding.utf8)
            
            //ADDS DATA TO PDF VERY IMPORTANT
            html = addDataToPDF(oldHTML: html,resumeNumber: "resume3")
            
        } else {
            htmlFile = Bundle.main.path(forResource: "resume4", ofType: "html")!
            html = try! String(contentsOfFile: htmlFile, encoding: String.Encoding.utf8)
            
            //ADDS DATA TO PDF VERY IMPORTANT
            html = addDataToPDF(oldHTML: html,resumeNumber: "resume4")
        }
        
        //informationController.saveChangeText(text: String(reloadCounter))
        //reloadCounter += 1
        
        //html = "<b>Hello <i>World!</i></b>"
        
        let fmt = UIMarkupTextPrintFormatter(markupText: html)
        
        // 2. Assign print formatter to UIPrintPageRenderer
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAt: 0)
        
        // 3. Assign paperRect and printableRect
        //let A4paperSize = CGSize(width: 2771, height: 3586)
        //let page = CGRect(x: 0, y: 0, width: 2771, height: 3586)
        
        
        /**
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
        
        
        
        */
        
        let fileName = "pdffilename.pdf"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0] as! NSString
        let outputURL = documentsDirectory.appending("/" + fileName)
        //let outputURL = URL()
        
        //URL(fileURLWithPath: <#T##String#>)
        
        
        
        //IMPORTANT SAVING
        /**
        let newData = pdfData.copy() as! NSData
        
        newData.write(to: URL(fileURLWithPath: outputURL), atomically: true)
        print("DATA")
        */
        
        print("open \(outputURL)")
        print("ARYA ME" + String(describing: outputURL))
        
        //webView.loadHTMLString(html!, baseURL: outputURL)
     
    return (html, outputURL)
        
       
        
    }
    
   
    
    var newHTML = " "
    func addDataToPDF(oldHTML: String, resumeNumber: String) ->String {
        loadData()
        let aUser = user.last
        
        
        
        
        
       
        
        
        guard let email  = aUser?.value(forKeyPath: "emailAdress") as? String  else {
            //print("nothing to see here")
            return ""
        }
        
        guard let phoneNumber  = aUser?.value(forKeyPath: "phoneNumber") as? String  else {
            //print("nothing to see here")
            return ""
        }
       
        
        
        
        
        skills = aUser?.value(forKeyPath: "skills") as? String
        
        professionalDevelopment  = aUser?.value(forKeyPath: "experience") as? String
        courses = aUser?.value(forKeyPath: "courses") as? String
        extracurriculars = aUser?.value(forKeyPath: "extracurriculars") as? String
        objective = aUser?.value(forKeyPath: "objective") as? String
        
        
        
        //Replace Name
        
        //let phoneNumber
        
        let myFirstName = aUser?.value(forKeyPath: "firstName") as? String
        let myLastName = aUser?.value(forKeyPath: "lastName") as? String
        
        professionalDevelopment  = aUser?.value(forKeyPath: "experience") as? String
        
        newHTML = oldHTML.replacingOccurrences(of: "YourNameHere", with: myFirstName! + " " + myLastName!)
        newHTML = newHTML.replacingOccurrences(of: "YourPhoneNumberHere", with: "Phone Number: " + phoneNumber)
        newHTML = newHTML.replacingOccurrences(of: "YourEmailHere", with: "Email: " + email)
        
        if(resumeNumber == "resume1"){
            newHTML = oldHTML.replacingOccurrences(of: "YourNameHere", with: myFirstName! + " " + myLastName!)
            newHTML = newHTML.replacingOccurrences(of: "YourPhoneNumberHere", with:"Phone Number:  " + phoneNumber)
            newHTML = newHTML.replacingOccurrences(of: "YourEmailHere", with:"Email:  " + email)
            if(objective != nil){
                var objectiveHTML = ""
                
                newHTML = newHTML.replacingOccurrences(of: "ObjectiveGoHere", with: objective)
                
                
            } else {
                
                newHTML = newHTML.replacingOccurrences(of: "<p class=\"head\">Objective</p><dl>ObjectiveGoHere</dl>", with: "")
            }
            
            if(skills != nil){
                var skillArr = skills.components(separatedBy:"-")
                
                var skillHTML = ""
                for aSkill in skillArr{
                    let skillDescription = aSkill.components(separatedBy:"_")
                    
                    skillHTML += (String(format: "<h3>%@</h3><ul><li>%@</li></ul>", skillDescription[1],skillDescription[2]))
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "SkillsGoHere", with: skillHTML)
            } else {
                newHTML = newHTML.replacingOccurrences(of: "<p class=\"head\">Skills</p><dl>SkillsGoHere</dl>", with: "")
                
            }
            
            if(professionalDevelopment != nil){
                var experienceArr = professionalDevelopment.components(separatedBy:"-")
                
                var experienceHTML = ""
                for anExperience in experienceArr{
                    print(anExperience)
                    let experienceDescription = anExperience.components(separatedBy:"_")
                    print(experienceDescription)
                    experienceHTML += (String(format: "<h3>%@</h3><h4>%@</h4><ul><li>%@</li></ul>",experienceDescription[4], experienceDescription[1] + " - " + experienceDescription[2] + "-" + experienceDescription[3],experienceDescription[6]))
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "ExperienceGoHere", with: experienceHTML)
                
            } else {
                newHTML = newHTML.replacingOccurrences(of: "<p class=\"head\">Internship and Job Experience</p><dl>ExperienceGoHere</dl>", with: "")
                //newHTML = newHTML.replacingOccurrences(of: "<p class=\"head\">Internship and Job Experience</p><dl>ExperienceGoHere</dl>", with: "")
                
            }
            
            
            if(extracurriculars != nil){
                var extracurricularsArr = extracurriculars.components(separatedBy:"-")
                
                var extracurricularHTML = ""
                for anAward in extracurricularsArr{
                    let extracurricularDescription = anAward.components(separatedBy:"_")
                    
                    extracurricularHTML += (String(format: "<h3>%@</h3><ul><li>%@</li></ul>", extracurricularDescription[1],extracurricularDescription[2]))
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "extracurricularsGoHere", with: extracurricularHTML)
            } else {
                newHTML = newHTML.replacingOccurrences(of: "<p class=\"head\">Extracurricular Activities</p><dl>extracurricularsGoHere</dl>", with: "")
            }
            
            
            //Courses loaded here
            if(courses != nil){
                var coursesArr = courses.components(separatedBy:"-")
                
                var courseHTML = ""
                for aCourse in coursesArr{
                    let courseDescription = aCourse.components(separatedBy:"_")
                    
                    courseHTML += (String(format: "<h3>%@</h3><ul><li>%@</li></ul>", courseDescription[1],courseDescription[2]))
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "CoursesGoHere", with: courseHTML)
            } else {
                newHTML = newHTML.replacingOccurrences(of: "<p class=\"head\">Courses Taken</p><dl>CoursesGoHere</dl>", with: "")
            }
            
            
            
            
            return newHTML
        } else if(resumeNumber == "resume2"){
            
            newHTML = oldHTML.replacingOccurrences(of: "YourNameHere", with: myFirstName! + " " + myLastName!)
            newHTML = newHTML.replacingOccurrences(of: "YourPhoneNumberHere", with: phoneNumber)
            newHTML = newHTML.replacingOccurrences(of: "YourEmailHere", with: email)
            if(objective != nil){
                var objectiveHTML = ""
                objectiveHTML += (String(format: "<h2>%@</h2><p>%@</p>","Objectives", objective))
                newHTML = newHTML.replacingOccurrences(of: "ObjectiveGoHere", with: objectiveHTML)
               
                
            } else {
                newHTML = newHTML.replacingOccurrences(of: "</div><div id=\"objective\"><p>ObjectiveGoHere</p></div>", with: "")
                
            }
            
            if(skills != nil){
                var skillArr = skills.components(separatedBy:"-")
                
                var skillHTML = ""
                for aSkill in skillArr{
                    let skillDescription = aSkill.components(separatedBy:"_")
                    
                    skillHTML += (String(format: "<h2>%@</h2><p>%@</p>", skillDescription[1],skillDescription[2]))
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "SkillsGoHere", with: skillHTML)
            } else {
                newHTML = newHTML.replacingOccurrences(of: "<dd class=\"clear\"></dd><dt>Skills</dt><dd>SkillsGoHere</dd>", with: "")
            }
            
            if(professionalDevelopment != nil){
                var experienceArr = professionalDevelopment.components(separatedBy:"-")
                
                var experienceHTML = ""
                for anExperience in experienceArr{
                    print(anExperience)
                    let experienceDescription = anExperience.components(separatedBy:"_")
                    print(experienceDescription)
                    experienceHTML += (String(format: "<h2>%@<span>%@</span></h2><ul><li>%@</li></ul>", experienceDescription[4],experienceDescription[1] + " - " + experienceDescription[2] + "-" + experienceDescription[3],experienceDescription[6]))
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "ExperienceGoHere", with: experienceHTML)
                
            }else {
                newHTML = newHTML.replacingOccurrences(of: "<dd class=\"clear\"></dd><dt>Internship and Job Experience</dt><dd>ExperienceGoHere</dd>", with: "")
            }
            
            
            if(extracurriculars != nil){
                var extracurricularsArr = extracurriculars.components(separatedBy:"-")
                
                var extracurricularHTML = ""
                for anAward in extracurricularsArr{
                    let extracurricularDescription = anAward.components(separatedBy:"_")
                    
                    extracurricularHTML += (String(format: "<h2>%@</h2><p>%@</p>", extracurricularDescription[1],extracurricularDescription[2]))
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "extracurricularsGoHere", with: extracurricularHTML)
            }else {
                newHTML = newHTML.replacingOccurrences(of: "<dd class=\"clear\"></dd><dt>Extracurricular Activities</dt><dd>extracurricularsGoHere</dd>", with: "")
            }
            
            
            //Courses loaded here
            if(courses != nil){
                var coursesArr = courses.components(separatedBy:"-")
                
                var courseHTML = ""
                for aCourse in coursesArr{
                    let courseDescription = aCourse.components(separatedBy:"_")
                    
                     courseHTML += (String(format: "<h2>%@</h2><p>%@</p>", courseDescription[1],courseDescription[2]))
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "CoursesGoHere", with: courseHTML)
            }else {
                newHTML = newHTML.replacingOccurrences(of: "<dd class=\"clear\"></dd><dt>Courses Taken</dt><dd>CoursesGoHere</dd>", with: "")
            }
            
            
            
            
            return newHTML
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        } else if(resumeNumber == "resume3"){
            newHTML = oldHTML.replacingOccurrences(of: "YourNameHere", with: myFirstName! + " " + myLastName!)
            newHTML = newHTML.replacingOccurrences(of: "YourPhoneNumberHere", with:"Phone Number:  " + phoneNumber)
            newHTML = newHTML.replacingOccurrences(of: "YourEmailHere", with:"Email:  " + email)
            if(objective != nil){
                var objectiveHTML = ""
                
                newHTML = newHTML.replacingOccurrences(of: "ObjectiveGoHere", with: objective)
                
                
            } else {
                newHTML = newHTML.replacingOccurrences(of: "<div class=\"yui-gf\"><div class=\"yui-u first\"><h2>Objective</h2></div><div class=\"yui-u\"><p class=\"enlarge\">ObjectiveGoHere</p></div></div>", with: "")
            }
            
            if(skills != nil){
                var skillArr = skills.components(separatedBy:"-")
                
                var skillHTML = ""
                for aSkill in skillArr{
                    let skillDescription = aSkill.components(separatedBy:"_")
                    
                    skillHTML += (String(format: "<div class=talent><h2>%@</h2><p>%@</p></div>", skillDescription[1],skillDescription[2]))
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "SkillsGoHere", with: skillHTML)
            } else {
                newHTML = newHTML.replacingOccurrences(of: "<div class=\"yui-gf\"><div class=\"yui-u first\"><h2>Skills</h2></div><div class=\"yui-u\">SkillsGoHere</div>", with: "")
            }
            
            if(professionalDevelopment != nil){
                var experienceArr = professionalDevelopment.components(separatedBy:"-")
                
                var experienceHTML = ""
                for anExperience in experienceArr{
                    print(anExperience)
                    let experienceDescription = anExperience.components(separatedBy:"_")
                    print(experienceDescription)
                    experienceHTML += (String(format: "<div class=job><h2>%@</h2><h3>%@</h3><h4>%@</h4><p>%@</p></div>",experienceDescription[4],experienceDescription[1],experienceDescription[2] + "-" + experienceDescription[3],experienceDescription[6]))
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "ExperienceGoHere", with: experienceHTML)
                
            } else {
                newHTML = newHTML.replacingOccurrences(of: "<div class=\"yui-gf\"><div class=\"yui-u first\"><h2>Experience</h2></div><div class=\"yui-u\">ExperienceGoHere</div></div>", with: "")
            }
            
            
            if(extracurriculars != nil){
                var extracurricularsArr = extracurriculars.components(separatedBy:"-")
                
                var extracurricularHTML = ""
                print("your aextras are")
                print(extracurricularsArr)
                for anAward in extracurricularsArr{
                    let extracurricularDescription = anAward.components(separatedBy:"_")
                    
                    extracurricularHTML += (String(format: "<div class=talent><h2>%@</h2><p>%@</p></div>", extracurricularDescription[1],extracurricularDescription[2]))
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "extracurricularsGoHere", with: extracurricularHTML)
            }else {
                newHTML = newHTML.replacingOccurrences(of: "<div class=\"yui-gf\"><div class=\"yui-u first\"><h2>ExtraCurriculars</h2></div><div class=\"yui-u\">extracurricularsGoHere</div>", with: "")
            }
            
            
            //Courses loaded here
            if(courses != nil){
                var coursesArr = courses.components(separatedBy:"-")
                
                var courseHTML = ""
                for aCourse in coursesArr{
                    let courseDescription = aCourse.components(separatedBy:"_")
                    
                    courseHTML += (String(format: "<div class=talent><h2>%@</h2><p>%@</p></div>", courseDescription[1],courseDescription[2]))
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "CoursesGoHere", with: courseHTML)
            }else {
                newHTML = newHTML.replacingOccurrences(of: "<div class=\"yui-gf\"><div class=\"yui-u first\"><h2>Courses</h2></div><div class=\"yui-u\">CoursesGoHere</div>", with: "")
            }
            
            
            
            
            
            
            return newHTML
        }
        
        
        // loading for resume 4
        
        
        
        
        newHTML = oldHTML.replacingOccurrences(of: "YourNameHere", with: myFirstName! + " " + myLastName!)
        newHTML = newHTML.replacingOccurrences(of: "YourPhoneNumberHere", with:"Phone Number:  " + phoneNumber)
        newHTML = newHTML.replacingOccurrences(of: "YourEmailHere", with:"Email:  " + email)
        if(objective != nil){
            var objectiveHTML = ""
            
            newHTML = newHTML.replacingOccurrences(of: "ObjectiveGoHere", with: objective)
            
            
        } else {
            newHTML = newHTML.replacingOccurrences(of: "<section><article><div class=\"sectionTitle\"><h1>Objective</h1></div><div class=\"sectionContent\"><p>ObjectiveGoHere</p></div></article><div class=\"clear\"></div></section>", with: "")
        }
        
        if(skills != nil){
            var skillArr = skills.components(separatedBy:"-")
            
            var skillHTML = ""
            for aSkill in skillArr{
                let skillDescription = aSkill.components(separatedBy:"_")
                
                skillHTML += (String(format: "<article><h2>%@</h2><p>%@</p></article>", skillDescription[1],skillDescription[2]))
                
            }
            newHTML = newHTML.replacingOccurrences(of: "SkillsGoHere", with: skillHTML)
        } else {
            newHTML = newHTML.replacingOccurrences(of: "<section><div class=\"sectionTitle\"><h1>Skills</h1></div><div class=\"sectionContent\"><ul class=\"keySkills\"><ul style=\"list-style-type:none\">SkillsGoHere</ul></ul></div><div class=\"clear\"></div></section>", with: "")
            
        }
        
        if(professionalDevelopment != nil){
            var experienceArr = professionalDevelopment.components(separatedBy:"-")
            
            var experienceHTML = ""
            for anExperience in experienceArr{
                print(anExperience)
                let experienceDescription = anExperience.components(separatedBy:"_")
                print(experienceDescription)
                experienceHTML += (String(format: "<article><h2>%@</h2><pclass=subDetails>%@</p><p>%@</p></article>",experienceDescription[4],experienceDescription[1] + " - " + experienceDescription[2] + "-" + experienceDescription[3],experienceDescription[6]))
                
            }
            newHTML = newHTML.replacingOccurrences(of: "ExperienceGoHere", with: experienceHTML)
            
        } else {
            newHTML = newHTML.replacingOccurrences(of: "<section><div class=\"sectionTitle\"><h1>Internship and Job Experience</h1></div><div class=\"sectionContent\">ExperienceGoHere</div><div class=\"clear\"></div></section>", with: "")
        }
        
        
        if(extracurriculars != nil){
            var extracurricularsArr = extracurriculars.components(separatedBy:"-")
            
            var extracurricularHTML = ""
            for anAward in extracurricularsArr{
                let extracurricularDescription = anAward.components(separatedBy:"_")
                
                extracurricularHTML += (String(format: "<article><h2>%@</h2><p>%@</p></article>", extracurricularDescription[1],extracurricularDescription[2]))
                
            }
            newHTML = newHTML.replacingOccurrences(of: "extracurricularsGoHere", with: extracurricularHTML)
        } else {
            newHTML = newHTML.replacingOccurrences(of: "<section><div class=\"sectionTitle\"><h1>Extracurriculars</h1></div><div class=\"sectionContent\"><ul class=\"keySkills\"><ul style=\"list-style-type:none\">extracurricularsGoHere</ul></ul></div><div class=\"clear\"></div></section>", with: "")
        }
        
        
        //Courses loaded here
        if(courses != nil){
            var coursesArr = courses.components(separatedBy:"-")
            
            var courseHTML = ""
            for aCourse in coursesArr{
                let courseDescription = aCourse.components(separatedBy:"_")
                
                courseHTML += (String(format: "<article><h2>%@</h2><p>%@</p></article>", courseDescription[1],courseDescription[2]))
                
            }
            newHTML = newHTML.replacingOccurrences(of: "CoursesGoHere", with: courseHTML)
        } else {
            newHTML = newHTML.replacingOccurrences(of: "<section><div class=\"sectionTitle\"><h1>Courses</h1></div><div class=\"sectionContent\"><ul class=\"keySkills\"><ul style=\"list-style-type:none\">CoursesGoHere</ul></ul></div><div class=\"clear\"></div></section>", with: "")
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
        extracurriculars = aUser?.value(forKeyPath: "extracurriculars") as? String
        
        let gradeLevel = ""
        let secondline = ( ("\(firstName) \(lastName) \n\(email)") + " \n\(phoneNumber)\n\(schoolName)\n\(gradeLevel)\n\("SKILLS")\n\(loadEntryItems(anEntry: skills))\n\("PROFESSIONAL DEVELOPMENT")\n\(loadEntryItems(anEntry: professionalDevelopment))\n\("COURSES TAKEN")\n\(loadEntryItems(anEntry: courses))\n\("extracurriculars")\n\(loadEntryItems(anEntry: extracurriculars))")
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
        
        var managedContext:NSManagedObjectContext
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        
        let userRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        //let timeRequest = NSFetchRequest<NSManagedObject>(entityName: "Time")
        do {
            user = try managedContext.fetch(userRequest)
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
