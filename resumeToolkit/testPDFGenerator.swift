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
    var user:user!
    var skills:[skill]!
    var professionalDevelopment:[experience]!
    var courses:[course]!
    var extracurriculars:[extracurricular]!
    var objective:String! = " "
    var resumeIndex = 1
    var dataController = newDataManager()
    init() {
        professionalDevelopment = dataController.fetchExperiences()
        courses = dataController.fetchCourses()
        extracurriculars = dataController.fetchExtraCurriculars()
        skills = dataController.fetchSkills()
       
        
    }
    
    
    
    
    var reloadCounter = 0
    var html = ""
    /// Returns the resume as an HTML string, as well as the file path where the resume is saved
    ///
    /// - Parameter indexAt: the resume selected. I.E resume1, resume2...Ect
    /// - Returns: html string of resume, filepath to resume
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
        let documentsDirectory = paths[0] as NSString
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
    /// Takes in the Html string and replaces the fillers with actual resume data.
    ///
    /// - Parameters:
    ///   - oldHTML: the old unedited HTML string
    ///   - resumeNumber: the selected resume. I.E resume1,resume2,
    /// - Returns: the final HTML string, edited with data.
    func addDataToPDF(oldHTML: String, resumeNumber: String) ->String {
        
        _ = dataController.getUser()
        
        
        
        
        
        let myFirstName = dataController.getUser().firstName
        let myLastName = dataController.getUser().lastName
        let email = dataController.getUser().emailAddress
        let phoneNumber = dataController.getUser().phoneNumber
        
        
        
       
        
        
        
        
        skills = dataController.fetchSkills()
        
        professionalDevelopment  = dataController.fetchExperiences()
        courses = dataController.fetchCourses()
        extracurriculars = dataController.fetchExtraCurriculars()
        objective = dataController.getUser().objective
        
        
        
    
        
        newHTML = oldHTML.replacingOccurrences(of: "YourNameHere", with: myFirstName + " " + myLastName)
        newHTML = newHTML.replacingOccurrences(of: "YourPhoneNumberHere", with: "Phone Number: " + phoneNumber)
        newHTML = newHTML.replacingOccurrences(of: "YourEmailHere", with: "Email: " + email)
        
        
        
        if(resumeNumber == "resume1"){
            newHTML = oldHTML.replacingOccurrences(of: "YourNameHere", with: myFirstName + " " + myLastName)
            newHTML = newHTML.replacingOccurrences(of: "YourPhoneNumberHere", with:"Phone Number:  " + phoneNumber)
            newHTML = newHTML.replacingOccurrences(of: "YourEmailHere", with:"Email:  " + email)
            if(objective != nil){
                _ = ""
                
                newHTML = newHTML.replacingOccurrences(of: "ObjectiveGoHere", with: objective)
                
                
            } else {
                
                newHTML = newHTML.replacingOccurrences(of: "<p class=\"head\">Objective</p><dl>ObjectiveGoHere</dl>", with: "")
            }
            
            if(!skills.isEmpty){
                var skillHTML = ""
                for aSkill in skills{
                    
                    skillHTML += (String(format: "<h3>%@</h3><ul><li>%@</li></ul>", String(aSkill.name), String(aSkill.skillDescription)))
                        
                    
                    
                    
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "SkillsGoHere", with: skillHTML)
            } else {
                newHTML = newHTML.replacingOccurrences(of: "<p class=\"head\">Skills</p><dl>SkillsGoHere</dl>", with: "")
                
            }
            
            if(!professionalDevelopment .isEmpty){
                
                
                var experienceHTML = ""
                for anExperience in professionalDevelopment{
                    experienceHTML += (String(format: "<h3>%@</h3><h4>%@</h4><ul><li>%@</li></ul>",anExperience.companyName, anExperience.name + " - " + anExperience.yearStarted + "-" + anExperience.yearEnded, anExperience.companyDescription))
                }
                   
                
                newHTML = newHTML.replacingOccurrences(of: "ExperienceGoHere", with: experienceHTML)
                
            } else {
                newHTML = newHTML.replacingOccurrences(of: "<p class=\"head\">Internship and Job Experience</p><dl>ExperienceGoHere</dl>", with: "")
                //newHTML = newHTML.replacingOccurrences(of: "<p class=\"head\">Internship and Job Experience</p><dl>ExperienceGoHere</dl>", with: "")
                
            }
            
            
            if(!extracurriculars.isEmpty){
               
                
                var extracurricularHTML = ""
                for anEC in extracurriculars{
                    extracurricularHTML += (String(format: "<h3>%@</h3><ul><li>%@</li></ul>", anEC.name, anEC.ecDescription))
                   
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "extracurricularsGoHere", with: extracurricularHTML)
            } else {
                newHTML = newHTML.replacingOccurrences(of: "<p class=\"head\">Extracurricular Activities</p><dl>extracurricularsGoHere</dl>", with: "")
            }
            
            
            //Courses loaded here
            if(!courses.isEmpty){
                
                
                var courseHTML = ""
                for aCourse in courses{
                    courseHTML += (String(format: "<h3>%@</h3><ul><li>%@</li></ul>", aCourse.name, aCourse.courseDescription))
                    
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "CoursesGoHere", with: courseHTML)
            } else {
                newHTML = newHTML.replacingOccurrences(of: "<p class=\"head\">Courses Taken</p><dl>CoursesGoHere</dl>", with: "")
            }
            
            
            
            
            return newHTML
        } else if(resumeNumber == "resume2"){
            
            newHTML = oldHTML.replacingOccurrences(of: "YourNameHere", with: myFirstName + " " + myLastName)
            newHTML = newHTML.replacingOccurrences(of: "YourPhoneNumberHere", with: phoneNumber)
            newHTML = newHTML.replacingOccurrences(of: "YourEmailHere", with: email)
            if(objective != nil){
                var objectiveHTML = ""
                objectiveHTML += (String(format: "<h2>%@</h2><p>%@</p>","Objectives", objective))
                newHTML = newHTML.replacingOccurrences(of: "ObjectiveGoHere", with: objectiveHTML)
               
                
            } else {
                newHTML = newHTML.replacingOccurrences(of: "</div><div id=\"objective\"><p>ObjectiveGoHere</p></div>", with: "")
                
            }
            
            if(!skills.isEmpty){
                
                
                var skillHTML = ""
                for aSkill in skills{
                    skillHTML += (String(format: "<h2>%@</h2><p>%@</p>", aSkill.name,aSkill.skillDescription))
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "SkillsGoHere", with: skillHTML)
            } else {
                newHTML = newHTML.replacingOccurrences(of: "<dd class=\"clear\"></dd><dt>Skills</dt><dd>SkillsGoHere</dd>", with: "")
            }
            
            if(!professionalDevelopment.isEmpty){
                
                
                var experienceHTML = ""
                for anExperience in professionalDevelopment{
                     experienceHTML += (String(format: "<h2>%@<span>%@</span></h2><ul><li>%@</li></ul>", anExperience.companyName, anExperience.name + " - " + anExperience.yearStarted + "-" + anExperience.yearEnded ,anExperience.companyDescription))
                   
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "ExperienceGoHere", with: experienceHTML)
                
            }else {
                newHTML = newHTML.replacingOccurrences(of: "<dd class=\"clear\"></dd><dt>Internship and Job Experience</dt><dd>ExperienceGoHere</dd>", with: "")
            }
            
            
            if(!extracurriculars.isEmpty){
                
                
                var extracurricularHTML = ""
                for anEC in extracurriculars{
                    extracurricularHTML += (String(format: "<h2>%@</h2><p>%@</p>", anEC.name, anEC.ecDescription))
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "extracurricularsGoHere", with: extracurricularHTML)
            }else {
                newHTML = newHTML.replacingOccurrences(of: "<dd class=\"clear\"></dd><dt>Extracurricular Activities</dt><dd>extracurricularsGoHere</dd>", with: "")
            }
            
            
            //Courses loaded here
            if(!courses.isEmpty){
                
                
                var courseHTML = ""
                for aCourse in courses{
                    courseHTML += (String(format: "<h2>%@</h2><p>%@</p>", aCourse.name, aCourse.courseDescription))
                   
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "CoursesGoHere", with: courseHTML)
            }else {
                newHTML = newHTML.replacingOccurrences(of: "<dd class=\"clear\"></dd><dt>Courses Taken</dt><dd>CoursesGoHere</dd>", with: "")
            }
            
            
            
            
            return newHTML
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        } else if(resumeNumber == "resume3"){
            newHTML = oldHTML.replacingOccurrences(of: "YourNameHere", with: myFirstName + " " + myLastName)
            newHTML = newHTML.replacingOccurrences(of: "YourPhoneNumberHere", with:"Phone Number:  " + phoneNumber)
            newHTML = newHTML.replacingOccurrences(of: "YourEmailHere", with:"Email:  " + email)
            if(objective != nil){
                _ = ""
                
                newHTML = newHTML.replacingOccurrences(of: "ObjectiveGoHere", with: objective)
                
                
            } else {
                newHTML = newHTML.replacingOccurrences(of: "<div class=\"yui-gf\"><div class=\"yui-u first\"><h2>Objective</h2></div><div class=\"yui-u\"><p class=\"enlarge\">ObjectiveGoHere</p></div></div>", with: "")
            }
            
            if(!skills.isEmpty){
                
                
                var skillHTML = ""
                for aSkill in skills {
                    
                    skillHTML += (String(format: "<div class=talent><h2>%@</h2><p>%@</p></div>", aSkill.name, aSkill.skillDescription))
                    
                
                }
                newHTML = newHTML.replacingOccurrences(of: "SkillsGoHere", with: skillHTML)
            } else {
                newHTML = newHTML.replacingOccurrences(of: "<div class=\"yui-gf\"><div class=\"yui-u first\"><h2>Skills</h2></div><div class=\"yui-u\">SkillsGoHere</div>", with: "")
            }
            
            if(!professionalDevelopment.isEmpty){
                
                
                var experienceHTML = ""
                for anExperience in professionalDevelopment{
                    experienceHTML += (String(format: "<div class=job><h2>%@</h2><h3>%@</h3><h4>%@</h4><p>%@</p></div>",anExperience.companyName,anExperience.name, anExperience.yearStarted + "-" + anExperience.yearEnded ,anExperience.companyDescription))
                    
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "ExperienceGoHere", with: experienceHTML)
                
            } else {
                newHTML = newHTML.replacingOccurrences(of: "<div class=\"yui-gf\"><div class=\"yui-u first\"><h2>Experience</h2></div><div class=\"yui-u\">ExperienceGoHere</div>", with: "")
            }
            
            
            if(!extracurriculars.isEmpty){
                
                
                var extracurricularHTML = ""
                
                for anAward in extracurriculars {
                    
                    extracurricularHTML += (String(format: "<div class=talent><h2>%@</h2><p>%@</p></div>", anAward.name, anAward.ecDescription))
                    
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "extracurricularsGoHere", with: extracurricularHTML)
            }else {
                newHTML = newHTML.replacingOccurrences(of: "<div class=\"yui-gf\"><div class=\"yui-u first\"><h2>ExtraCurriculars</h2></div><div class=\"yui-u\">extracurricularsGoHere</div>", with: "")
            }
            
            
            //Courses loaded here
            if(!courses.isEmpty){
                
                
                var courseHTML = ""
                for aCourse in courses{
                    
                    
                    courseHTML += (String(format: "<div class=talent><h2>%@</h2><p>%@</p></div>", aCourse.name ,aCourse.courseDescription))
                    
                }
                newHTML = newHTML.replacingOccurrences(of: "CoursesGoHere", with: courseHTML)
            }else {
                newHTML = newHTML.replacingOccurrences(of: "<div class=\"yui-gf\"><div class=\"yui-u first\"><h2>Courses</h2></div><div class=\"yui-u\">CoursesGoHere</div>", with: "")
            }
            
            
            
            
            
            
            return newHTML
        }
        
        
        // loading for resume 4
        
        
        
        
        newHTML = oldHTML.replacingOccurrences(of: "YourNameHere", with: myFirstName + " " + myLastName)
        newHTML = newHTML.replacingOccurrences(of: "YourPhoneNumberHere", with:"Phone Number:  " + phoneNumber)
        newHTML = newHTML.replacingOccurrences(of: "YourEmailHere", with:"Email:  " + email)
        if(objective != nil){
            _ = ""
            
            newHTML = newHTML.replacingOccurrences(of: "ObjectiveGoHere", with: objective)
            
            
        } else {
            newHTML = newHTML.replacingOccurrences(of: "<section><article><div class=\"sectionTitle\"><h1>Objective</h1></div><div class=\"sectionContent\"><p>ObjectiveGoHere</p></div></article><div class=\"clear\"></div></section>", with: "")
        }
        
        if(!skills.isEmpty){
            
            
            
            var skillHTML = ""
            for aSkill in skills{
                skillHTML += (String(format: "<article><h2>%@</h2><p>%@</p></article>", aSkill.name, aSkill.skillDescription))
                
            }
            newHTML = newHTML.replacingOccurrences(of: "SkillsGoHere", with: skillHTML)
        } else {
            newHTML = newHTML.replacingOccurrences(of: "<section><div class=\"sectionTitle\"><h1>Skills</h1></div><div class=\"sectionContent\"><ul class=\"keySkills\"><ul style=\"list-style-type:none\">SkillsGoHere</ul></ul></div><div class=\"clear\"></div></section>", with: "")
            
        }
        
        if(!professionalDevelopment.isEmpty){
            
            
            var experienceHTML = ""
            for anExperience in professionalDevelopment{
                
                experienceHTML += (String(format: "<article><h2>%@</h2><pclass=subDetails>%@</p><p>%@</p></article>",anExperience.companyName,anExperience.name + " - " + anExperience.yearStarted + "-" + anExperience.yearEnded,anExperience.companyDescription))
                
                
            }
            newHTML = newHTML.replacingOccurrences(of: "ExperienceGoHere", with: experienceHTML)
            
        } else {
            newHTML = newHTML.replacingOccurrences(of: "<section><div class=\"sectionTitle\"><h1>Internship and Job Experience</h1></div><div class=\"sectionContent\">ExperienceGoHere</div><div class=\"clear\"></div></section>", with: "")
        }
        
        
        if(!extracurriculars.isEmpty){
            
            
            var extracurricularHTML = ""
            for anAward in extracurriculars{
                extracurricularHTML += (String(format: "<article><h2>%@</h2><p>%@</p></article>", anAward.name,anAward.ecDescription))
                
                
            }
            newHTML = newHTML.replacingOccurrences(of: "extracurricularsGoHere", with: extracurricularHTML)
        } else {
            newHTML = newHTML.replacingOccurrences(of: "<section><div class=\"sectionTitle\"><h1>Extracurriculars</h1></div><div class=\"sectionContent\"><ul class=\"keySkills\"><ul style=\"list-style-type:none\">extracurricularsGoHere</ul></ul></div><div class=\"clear\"></div></section>", with: "")
        }
        
        
        //Courses loaded here
        if(!courses.isEmpty){
            
            
            var courseHTML = ""
            for aCourse in courses{
                courseHTML += (String(format: "<article><h2>%@</h2><p>%@</p></article>", aCourse.name,aCourse.courseDescription))
                
                
            }
            newHTML = newHTML.replacingOccurrences(of: "CoursesGoHere", with: courseHTML)
        } else {
            newHTML = newHTML.replacingOccurrences(of: "<section><div class=\"sectionTitle\"><h1>Courses</h1></div><div class=\"sectionContent\"><ul class=\"keySkills\"><ul style=\"list-style-type:none\">CoursesGoHere</ul></ul></div><div class=\"clear\"></div></section>", with: "")
        }
        
        
        
        
        return newHTML
    }
    
    
    
    
    
    
    
    
    var restultantString = " "
    func loadEntryItems(anEntry: String?) -> String{
        restultantString = " "
        if anEntry != nil{
            
        } else {
            return " "
        }
        var separatedArr = anEntry?.components(separatedBy:"_")
        for index in 1...((separatedArr?.count)!-1){
            restultantString += "\n" + String(repeating: " ", count: index) + separatedArr![index]
        }
        
        return restultantString
    }
    
    
   
}
