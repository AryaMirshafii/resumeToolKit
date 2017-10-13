//
//  editViewController.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/7/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit
import Device_swift


class editViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    let dataController = dataManager()
    
    
    @IBOutlet weak var entryName: UITextField!
    @IBOutlet weak var entryDescription: UITextView!
    @IBOutlet weak var classList: UIView!
    
    @IBOutlet weak var nameView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
     @IBOutlet weak var classNamePicker: UIPickerView!
    
    
    @IBOutlet weak var classNamesLabel: UILabel!
    
    
    
    
    @IBOutlet weak var skillImage: UIImageView!
    @IBOutlet weak var entryLabel: UILabel!
    @IBOutlet weak var entrySwiper: UIView!
    
    
    //company experience stuff
    @IBOutlet weak var timelineView: UIView!
    @IBOutlet weak var companyView: UIView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var yearReceivedView: UIView!
    
    //textfields for professional development
    @IBOutlet weak var startEntry: UITextField!
    @IBOutlet weak var endEntry: UITextField!
    @IBOutlet weak var companyField: UITextField!
    @IBOutlet weak var contactField: UITextField!
    
    
    
    var pickerData: [String] = [String]()
    var entryType: String!
    
    var infoController = userInfo()
    
    var skillData: [String] = [String]()
    var courseData: [String] = [String]()
    var selectedItem = " "
    
    var reloadCounter = 0
    var previousSkill = " "
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGestures()
        entryDescription.text  = " "
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        
        
        pickerData.append("Skill")
        pickerData.append("Internships & Job Experience")
        pickerData.append("Courses")
        pickerData.append("Awards & Certifications")
        entryLabel.text = pickerData[0]
        setAlignment(row:0)
        loadSkills()
        loadCourses()
        
        
        self.classNamePicker.layer.cornerRadius = 20
        
        self.classNamePicker.dataSource = self
        self.classNamePicker.delegate = self
        
        
        
        
        entryType = pickerData[0]
        entryName.text = skillData[0]
        nameLabel.text = "Skill Name:"
        entryDescription.text = "Understanding the implications of new information for both current and future problem solving and decision making."
        //classList.isHidden = true
        //self.entryName.frame = CGRect(x: 126, y: 177, width: entryName.frame.width, height: entryName.frame.height)
        self.skillImage.layer.cornerRadius = skillImage.frame.width/2
        skillImage.clipsToBounds = true
        self.entryDescription.layer.cornerRadius = 20
        self.entryDescription.layer.borderColor = UIColor(red:0.00, green:0.58, blue:1.00, alpha:1.0).cgColor
        self.entryDescription.layer.borderWidth = 4
        self.skillImage.image = #imageLiteral(resourceName: "chalkboard")
        
    }
    func loadCourses(){
        courseData.append("PSYCH 2103")
        courseData.append("MUSI 1202")
        courseData.append("LMC 2500")
        courseData.append("SPAN 3823")
        courseData.append("MGT 4192")
        courseData.append("MGT 4193")
        courseData.append("APPH 1050")
        courseData.append("PSYC 1101")
        courseData.append("LMC 2500")
        courseData.append("APPH 1040")
        courseData.append("SPAN 2001")
        courseData.append("HTS 2015")
        courseData.append("MGT2200")
        courseData.append("HIST 2112")
        courseData.append("MUSI 1202")
        courseData.append("PSYC 1101")
        courseData.append("MGT 4193")
        courseData.append("HIST 2112")
        courseData.append("MUSI 3251")
        courseData.append("LMC 3252")
        courseData.append("JAP 1001")
        courseData.append("PSYC 1101")
        courseData.append("LMC 2600")
        courseData.append("SPAN 2001")
        courseData.append("PSYC 1101")
        courseData.append("LMC 2500")
        courseData.append("MGT 2200")
        
    }
    
    func loadSkills(){
        skillData.append("Active Learning")
        skillData.append("Active Listening")
        skillData.append("Critical Thinking")
        skillData.append("Learning Strategies")
        skillData.append("Mathematics")
        skillData.append("Monitoring")
        skillData.append("Reading Comprehension")
        skillData.append("Science")
        skillData.append("Speaking")
        skillData.append("Writing")
        skillData.append("Complex Problem Solving")
        skillData.append("Time Management")
        skillData.append("Coordination")
        skillData.append("Instructing")
        skillData.append("Negotiation")
        skillData.append("Persuasion")
        skillData.append("Service Orientation")
        skillData.append("Social Perceptiveness")
        skillData.append("Judgment and Decision Making")
        skillData.append("Equipment Maintenance")
        skillData.append("Equipment Selection")
        skillData.append("Installation")
        skillData.append("Operation and Control")
        skillData.append("Programming")
        skillData.append("Quality Control Analysis")
        skillData.append("Repairing")
        skillData.append("Technology Design")
        skillData.append("Troubleshooting")
        
    }
    @IBAction func goBack(_ sender: UIButton){
        
        print("!!!" + entryType!)
        if(entryType == "Skill"){
            classList.isHidden = true
            
            dataController.saveSkills(theSkills: "Skill" + "_" + entryName.text! + "_" + entryDescription.text)
        } else if(entryType == "Internships & Job Experience"){
            var experienceString =  "Professional Development" + "_" + entryName.text! + "_"
            experienceString += startEntry.text! + "_" + endEntry.text! + "_"
                
            experienceString += companyField.text! + "_" + contactField.text!
            experienceString +=   "_" + entryDescription.text
            dataController.saveExperience(experience: experienceString)
        } else if(entryType == "Courses"){
            dataController.saveCourses(courses: "Courses" + "_" + entryName.text! + "_" + entryDescription.text)
        } else if(entryType == "Awards & Certifications"){
            dataController.saveAwards(awardName: "Awards" + "_" + entryName.text! + "_" + entryDescription.text)
        }
        infoController.saveChangeText(text: String(reloadCounter))
        reloadCounter += 1
        dismiss(animated: true, completion: nil)
    }
    
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        if pickerView == classNamePicker{
            if(entryType == "Skill"){
                print("still ehre")
                return skillData.count
            } else if(entryType == "Courses"){
                print("row size = coursedata")
                return courseData.count
            }
        }
         
        print("i got here")
        return 1
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView == classNamePicker{
            if(entryType == "Skill"){
                return skillData[row]
            } else if(entryType == "Courses"){
                if(row <= courseData.count){
                    return courseData[row]
                }
                
            }
            
        }
        
        return " "
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if pickerView == classNamePicker {
            
            //selectedItem = skillData[row]
            //previousSkill = selectedItem
            //entryName.text = selectedItem
            //setDescriptions(slectedItem: selectedItem)
            
            if(entryType == "Skill"){
                skillImage.isHidden = false
                
                selectedItem = skillData[row]
                entryName.text = selectedItem
                self.skillImage.layer.cornerRadius = skillImage.frame.width/2
                skillImage.clipsToBounds = true
                setPicture(slectedItem: selectedItem)
                setDescriptions(slectedItem: selectedItem)
            } else if(entryType == "Courses"){
                self.skillImage.image = UIImage()
                self.skillImage.isHidden = true
                selectedItem = courseData[row]
                entryName.text = selectedItem
                setClassDescriptions(orClass: selectedItem)
            } else if(entryType == "Internships & Job Experience"){
                classList.isUserInteractionEnabled = false
                self.skillImage.image = UIImage()
                self.skillImage.isHidden = true
            } else if(entryType == "Awards & Certifications"){
                classList.isUserInteractionEnabled = false
                self.skillImage.image = UIImage()
                self.skillImage.isHidden = true
            }
            
            
            
        }
    }
    
    
    
    
    func setDescriptions(slectedItem: String){
        if(selectedItem == "Active Learning"){
            entryDescription.text = "Understanding the implications of new information for both current and future problem solving and decision making."
            entryName.text = "Active Learning"
        } else if (selectedItem == "Active Listening"){
            entryDescription.text = "Giving full attention to what other people are saying, taking time to understand the points being made, asking questions as appropriate, and not interrupting at inappropriate times."
            entryName.text = "Active Listening"
        } else if (selectedItem == "Critical Thinking"){
            entryDescription.text = "Using logic and reasoning to identify the strengths and weaknesses of alternative solutions, conclusions or approaches to problems."
            entryName.text = "Critical Thinking"
        } else if (selectedItem == "Learning Strategies"){
            entryDescription.text = "Selecting and using training/instructional methods and procedures appropriate for the situation when learning or teaching new things."
            entryName.text = "Learning Strategies"
        } else if (selectedItem == "Mathematics"){
            entryDescription.text = "Using mathematics to solve problems."
            entryName.text = "Mathematics"
        } else if (selectedItem == "Monitoring"){
            entryDescription.text = "Monitoring/Assessing performance of yourself, other individuals, or organizations to make improvements or take corrective action."
            entryName.text = "Monitoring"
        } else if (selectedItem == "Reading Comprehension"){
            entryDescription.text = "Understanding written sentences and paragraphs in work related documents."
            entryName.text = "Reading Comprehension"
        } else if (selectedItem == "Science"){
            entryDescription.text = "Using scientific rules and methods to solve problems."
            entryName.text = "Science"
        } else if (selectedItem == "Speaking"){
            entryDescription.text =  "Talking to others to convey information effectively."
            entryName.text = "Speaking"
        } else if (selectedItem == "Writing"){
            entryDescription.text = "Communicating effectively in writing as appropriate for the needs of the audience."
            entryName.text = "Writing"
        }
        
         else if (selectedItem == "Complex Problem Solving"){
            entryDescription.text = " Identifying complex problems and reviewing related information to develop and evaluate options and implement solutions."
            entryName.text = "Complex Problem Solving"
         } else if (selectedItem == "Time Management"){
            entryDescription.text = "Managing one's own time and the time of others. "
            entryName.text = "Time Management"
         } else if (selectedItem == "Coordination"){
            entryDescription.text = "Adjusting actions in relation to others' actions. "
            entryName.text = "Coordination"
         } else if (selectedItem == "Instructing"){
            entryDescription.text =  "Teaching others how to do something."
            entryName.text = "Instructing"
         } else if (selectedItem == "Negotiation"){
            entryDescription.text = " Bringing others together and trying to reconcile differences. "
            entryName.text = "Negotiation"
         } else if (selectedItem == "Persuasion"){
            entryDescription.text = "Persuading others to change their minds or behavior. "
            entryName.text = "Persuasion"
         } else if (selectedItem == "Service Orientation"){
            entryDescription.text = "Actively looking for ways to help people. "
            entryName.text = "Service Orientation"
         } else if (selectedItem == "Social Perceptiveness"){
            entryDescription.text = "Being aware of others' reactions and understanding why they react as they do. "
            entryName.text = "Social Perceptiveness"
         } else if (selectedItem == "Judgment and Decision Making"){
            entryDescription.text = "Considering the relative costs and benefits of potential actions to choose the most appropriate one. "
            entryName.text = "Judgment and Decision Making"
        } else if (selectedItem == "Equipment Maintenance"){
            entryDescription.text = "Performing routine maintenance on equipment and determining when and what kind of maintenance is needed. "
            entryName.text = "Equipment Maintenance"
        } else if (selectedItem == "Equipment Selection"){
            entryDescription.text = "Determining the kind of tools and equipment needed to do a job. "
            entryName.text = "Equipment Selection"
        } else if (selectedItem == "Installation"){
            entryDescription.text = "Installing equipment, machines, wiring, or programs to meet specifications. "
            entryName.text = "Installation"
        } else if (selectedItem == "Operation and Control"){
            entryDescription.text = "Controlling operations of equipment or systems. "
            entryName.text = "Operation and Control"
        } else if (selectedItem == "Programming"){
            entryDescription.text = "Writing computer programs for various purposes. "
            entryName.text = "Programming"
        } else if (selectedItem == "Quality Control Analysis"){
            entryDescription.text = "Conducting tests and inspections of products, services, or processes to evaluate quality or performance. "
            entryName.text = "Quality Control Analysis"
        } else if (selectedItem == "Repairing"){
            entryDescription.text = "Repairing machines or systems using the needed tools. "
            entryName.text = "Repairing"
        } else if (selectedItem == "Technology Design"){
            entryDescription.text = "Generating or adapting equipment and technology to serve user needs. "
            entryName.text = "Technology Design"
        } else if (selectedItem == "Troubleshooting"){
            entryDescription.text = "Determining causes of operating errors and deciding what to do about it."
            entryName.text = "Troubleshooting"
        }
        
        
        
    }
    
    func setPicture(slectedItem: String){
        if(selectedItem == "Active Learning"){
            
            self.skillImage.image = #imageLiteral(resourceName: "chalkboard")
        } else if (selectedItem == "Active Listening"){
            self.skillImage.image = #imageLiteral(resourceName: "ear")
        } else if (selectedItem == "Critical Thinking"){
            self.skillImage.image = #imageLiteral(resourceName: "brain")
        } else if (selectedItem == "Learning Strategies"){
            self.skillImage.image = #imageLiteral(resourceName: "strategy")
        } else if (selectedItem == "Mathematics"){
            self.skillImage.image = #imageLiteral(resourceName: "math")
        } else if (selectedItem == "Monitoring"){
            self.skillImage.image = #imageLiteral(resourceName: "monitoring")
        } else if (selectedItem == "Reading Comprehension"){
            self.skillImage.image = #imageLiteral(resourceName: "reading")
        } else if (selectedItem == "Science"){
            self.skillImage.image = #imageLiteral(resourceName: "science")
        } else if (selectedItem == "Speaking"){
            self.skillImage.image = #imageLiteral(resourceName: "speaking")
        } else if (selectedItem == "Writing"){
            self.skillImage.image = #imageLiteral(resourceName: "writing")
        }else if (selectedItem == "Complex Problem Solving"){
            self.skillImage.image = #imageLiteral(resourceName: "problemsolving")
        } else if (selectedItem == "Time Management"){
            self.skillImage.image = #imageLiteral(resourceName: "timemanagment")
        } else if (selectedItem == "Coordination"){
            self.skillImage.image = #imageLiteral(resourceName: "coordination")
        } else if (selectedItem == "Instructing"){
            self.skillImage.image = #imageLiteral(resourceName: "instructing")
        } else if (selectedItem == "Negotiation"){
            self.skillImage.image = #imageLiteral(resourceName: "negotiation")
        } else if (selectedItem == "Persuasion"){
            self.skillImage.image = #imageLiteral(resourceName: "persuasion")
        } else if (selectedItem == "Service Orientation"){
            self.skillImage.image = #imageLiteral(resourceName: "service")
        } else if (selectedItem == "Social Perceptiveness"){
            self.skillImage.image = #imageLiteral(resourceName: "social")
        } else if (selectedItem == "Judgment and Decision Making"){
            self.skillImage.image = #imageLiteral(resourceName: "judgement")
        } else if (selectedItem == "Equipment Maintenance"){
           self.skillImage.image = #imageLiteral(resourceName: "equipmentmaintenance")
        } else if (selectedItem == "Equipment Selection"){
            self.skillImage.image = #imageLiteral(resourceName: "equipmentselection")
        } else if (selectedItem == "Installation"){
            self.skillImage.image = #imageLiteral(resourceName: "installation")
        } else if (selectedItem == "Operation and Control"){
            self.skillImage.image = #imageLiteral(resourceName: "operation")
        } else if (selectedItem == "Programming"){
            self.skillImage.image = #imageLiteral(resourceName: "coding")
        } else if (selectedItem == "Quality Control Analysis"){
           self.skillImage.image = #imageLiteral(resourceName: "qualitycontroll")
        } else if (selectedItem == "Repairing"){
            self.skillImage.image = #imageLiteral(resourceName: "repair")
        } else if (selectedItem == "Technology Design"){
            self.skillImage.image = #imageLiteral(resourceName: "design")
        } else if (selectedItem == "Troubleshooting"){
            self.skillImage.image = #imageLiteral(resourceName: "installation")
        }
    }
    
    
    func setClassDescriptions(orClass: String){
        if(orClass == "PSYCH 2103"){
            entryDescription.text = "Behavioral Psychology" + "\n"
        } else if (orClass == "MUSI 1202"){
            entryDescription.text = "Chorale" + "\n"
        } else if (orClass == "LMC 2500"){
            entryDescription.text = "Introduction to Film" + "\n"
        } else if (orClass == "SPAN 3823"){
            entryDescription.text = "Latin American Music" + "\n"
        } else if (orClass == "MGT 4192"){
            entryDescription.text = "IMPACT Forum" + "\n"
        } else if (orClass == "MGT 4193"){
            entryDescription.text = "Servant Leadership" + "\n"
        } else if (orClass == "APPH 1050"){
            entryDescription.text = "Applied Physiology with workout" + "\n"
        } else if (orClass == "PSYC 1101"){
            entryDescription.text = "General Psychology" + "\n"
        } else if (orClass == "LMC 2500"){
            entryDescription.text = "Introduction to Film" + "\n"
        } else if (orClass == "APPH 1040"){
            entryDescription.text = "Applied Physiology" + "\n"
        } else if (orClass == "SPAN 2001"){
            entryDescription.text = "Intermediate Spanish" + "\n"
        } else if (orClass == "HTS 2015"){
            entryDescription.text = "History of Sports" + "\n"
        } else if (orClass == "MGT2200"){
            entryDescription.text = "Information Technology" + "\n"
        } else if (orClass == "HIST 2112"){
            entryDescription.text = "American History  1877 to present" + "\n"
        } else if (orClass == "MUSI 1202"){
            entryDescription.text = "Chorale" + "\n"
        } else if (orClass == "PSYC 1101"){
            entryDescription.text = "General Psychology" + "\n"
        } else if (orClass == "MGT 4193"){
            entryDescription.text = "Servant Leadership" + "\n"
        } else if (orClass == "MUSI 3251"){
            entryDescription.text =  "Glee Club" + "\n"
        } else if (orClass == "HIST 2112"){
            entryDescription.text = "American History  1877 to present" + "\n"
        } else if (orClass == "LMC 3252"){
            entryDescription.text = "Film and Television" + "\n"
        } else if (orClass == "JAP 1001"){
            entryDescription.text = "Beginners Japaneese" + "\n"
        } else if (orClass == "PSYC 1101"){
            entryDescription.text = "General Psychology" + "\n"
        } else if (orClass == "LMC 2600"){
            entryDescription.text = "Intro to Performance Studies" + "\n"
        } else if (orClass == "SPAN 2001"){
            entryDescription.text = "Intermediate Spanish" + "\n"
        } else if (orClass == "LMC 2500"){
            entryDescription.text = "Introduction to Film" + "\n"
        } else if (orClass == "MGT 2200"){
            entryDescription.text = "Information Technology" + "\n"
        }
    }
    
    
    @IBAction func exit(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    
    func setUpGestures(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        
        swipeRight.addTarget(self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        swipeRight.cancelsTouchesInView = false
        self.entrySwiper.addGestureRecognizer(swipeRight)
        //self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.cancelsTouchesInView = false
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.entrySwiper.addGestureRecognizer(swipeLeft)
        
    }
    
    var indx = 0
    
    @IBAction func rightTap(_ sender: UIButton){
        indx += 1
        if (indx > (pickerData.count - 1)){
            indx = 0
        } else if (indx < 0) {
            indx = pickerData.count - 1
        }
        entryLabel.text = pickerData[indx]
        setAlignment(row: indx)
    }
    
    
    @IBAction func leftTap(_ sender: UIButton){
        indx += 1
        if (indx > (pickerData.count - 1)){
            indx = 0
        } else if (indx < 0) {
            indx = pickerData.count - 1
        }
        entryLabel.text = pickerData[indx]
        setAlignment(row: indx)
    }
    
    
    
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        
        
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.left:
                indx += 1
                if (indx > (pickerData.count - 1)){
                    indx = 0
                } else if (indx < 0) {
                    indx = pickerData.count - 1
                }
                entryLabel.text = pickerData[indx]
                setAlignment(row: indx)
                
            case UISwipeGestureRecognizerDirection.right:
                indx -= 1
                if (indx > (pickerData.count - 1)){
                    indx = 0
                } else if (indx < 0) {
                    indx = pickerData.count - 1
                }
                
                entryLabel.text = pickerData[indx]
                setAlignment(row: indx)
                
            default:
                break
            }
        }
    }
    
    
    func setAlignment(row: Int){
        entryType = pickerData[row]
        print("the entry type is" +  entryType)
        if(entryType == "Skill"){
            classNamePicker.reloadAllComponents()
            classNamePicker.isUserInteractionEnabled = true
            classList.isUserInteractionEnabled = true
            classList.isHidden = false
            nameLabel.text = "Skill Name"
            classNamesLabel.text = "Skill Name"
            classNamesLabel.textAlignment = .left
            setDescriptions(slectedItem: entryType)
            setPicture(slectedItem: entryType)
            
            classList.frame = CGRect(x: 16, y: 133, width: 343, height: 134)
            nameView.frame = CGRect(x: 16, y: 83, width: 343, height: 52)
            
            entryDescription.frame = CGRect(x: 16, y: 280, width: 343, height: 94)
            entryDescription.autoresizesSubviews = true
            self.entrySwiper.frame = CGRect(x: 60, y: 33, width: 255, height: 42)
            
            timelineView.isHidden = true
            companyView.isHidden = true
            contactView.isHidden = true
            yearReceivedView.isHidden = true
            timelineView.frame = CGRect(x: 6, y: 700, width: 2, height: 2)
            companyView.frame = CGRect(x: 6, y: 700, width: 2, height: 2)
            contactView.frame = CGRect(x: 6, y: 700, width: 2, height: 2)
            yearReceivedView.frame = CGRect(x: 6, y: 700, width: 2, height: 2)
        } else if(entryType == "Internships & Job Experience"){
            
            skillImage.isHidden = true
            classNamePicker.reloadAllComponents()
            entryName.text = " "
            entryDescription.text = ""
            classNamesLabel.text = "Job Title"
            classList.isUserInteractionEnabled = false
            classNamePicker.isUserInteractionEnabled = false
            classList.isHidden = true
            
            timelineView.isHidden = false
            companyView.isHidden = false
            contactView.isHidden = false
            yearReceivedView.isHidden = true
            nameView.frame = CGRect(x: 16, y: 83, width: 343, height: 52)
            timelineView.frame = CGRect(x: 16, y: 135, width: 343, height: 52)
            companyView.frame = CGRect(x: 16, y: 189, width: 343, height: 52)
            contactView.frame = CGRect(x: 16, y: 242, width: 343, height: 52)
            entryDescription.frame = CGRect(x: 16, y: 294, width: 343, height: 94)
            self.entrySwiper.frame = CGRect(x: 60, y: 33, width: 255, height: 42)
            
            
            
            
            classList.frame = CGRect(x: 6, y: 700, width: 2, height: 2)
            yearReceivedView.frame = CGRect(x: 6, y: 700, width: 2, height: 2)
            
        }else if(entryType == "Courses") {
            
            
            skillImage.isHidden = true
            classNamePicker.reloadAllComponents()
            classList.isHidden = false
            classNamePicker.isUserInteractionEnabled = true
            classList.isUserInteractionEnabled = true
            nameLabel.text = "Course Name"
            classNamesLabel.text = "Course"
            entryDescription.text = ""
            
            classList.frame = CGRect(x: 16, y: 133, width: 343, height: 134)
            nameView.frame = CGRect(x: 16, y: 83, width: 343, height: 52)
            
            entryDescription.frame = CGRect(x: 16, y: 280, width: 343, height: 94)
            //setDescriptions(slectedItem: previousSkill)
            self.entrySwiper.frame = CGRect(x: 60, y: 33, width: 255, height: 42)
            timelineView.isHidden = true
            companyView.isHidden = true
            contactView.isHidden = true
            yearReceivedView.isHidden = true
            timelineView.frame = CGRect(x: 6, y: 700, width: 2, height: 2)
            companyView.frame = CGRect(x: 6, y: 700, width: 2, height: 2)
            contactView.frame = CGRect(x: 6, y: 700, width: 2, height: 2)
            yearReceivedView.frame = CGRect(x: 6, y: 700, width: 2, height: 2)
        } else if(entryType == "Awards & Certifications"){
            
            skillImage.isHidden = true
            classNamePicker.reloadAllComponents()
            entryName.text = " "
            entryDescription.text = ""
            classList.isHidden = true
            
            
            classNamesLabel.text = "Award Name:"
            classList.isUserInteractionEnabled = false
            classNamePicker.isUserInteractionEnabled = false
            yearReceivedView.isHidden = false
            
            
            nameView.frame = CGRect(x: 16, y: 83, width: 343, height: 52)
            yearReceivedView.frame = CGRect(x: 16, y: 154, width: 343, height: 52)
            entryDescription.frame = CGRect(x: 16, y: 240, width: 343, height: 94)
            self.entrySwiper.frame = CGRect(x: 60, y: 33, width: 255, height: 42)
            
            timelineView.isHidden = true
            companyView.isHidden = true
            contactView.isHidden = true
            classList.isHidden = true
            timelineView.frame = CGRect(x: 6, y: 700, width: 2, height: 2)
            companyView.frame = CGRect(x: 6, y: 700, width: 2, height: 2)
            contactView.frame = CGRect(x: 6, y: 700, width: 2, height: 2)
            classList.frame = CGRect(x: 6, y: 700, width: 2, height: 2)
            
            
            
            
        }
        
        
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        
        
        
        view.endEditing(true)
        
        
    }
}
