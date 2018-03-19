//
//  editViewController.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/7/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit
import Device



class editViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    //OVerall View
    
    @IBOutlet weak var swipeController: UIView!
    @IBOutlet weak var skillImage: UIImageView!
    
    @IBOutlet weak var swipeControllerLabel: UILabel!
    //SkillView
    
    @IBOutlet weak var skillView: UIView!
    @IBOutlet weak var skillPicker: UIPickerView!
    @IBOutlet weak var skillName: UITextField!
    @IBOutlet weak var skillDescription: UITextView!
    
    //JobView
    
    @IBOutlet weak var jobView: UIView!
    @IBOutlet weak var jobName: UITextField!
    @IBOutlet weak var startYearEntry: UITextField!
    @IBOutlet weak var endYearEntry: UITextField!
    @IBOutlet weak var organizationNameEntry: UITextField!
    @IBOutlet weak var contactNameEntry: UITextField!
    @IBOutlet weak var jobDescription: UITextView!
    
    
    
    //courseView
    
    @IBOutlet weak var courseView: UIView!
    @IBOutlet weak var courseNameEntry: UITextField!
    @IBOutlet weak var coursePicker: UIPickerView!
    @IBOutlet weak var courseDescription: UITextView!
    
    
    //ExtracurricularView
    
    @IBOutlet weak var extracurricularView: UIView!
    @IBOutlet weak var extracurricularNameEntry: UITextField!
    @IBOutlet weak var yearEntry: UITextField!
    
    @IBOutlet weak var extracurricularDescription: UITextView!
    
    
    
    
    
    
    
    let dataController = dataManager()
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
        
        //self.skillView.frame = CGRect(x: 0, y: 71, width: 375, height: 296)
        self.jobView.isHidden = true
       
        self.extracurricularView.isHidden = true
        
        self.courseView.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        
        
        pickerData.append("Skill")
        pickerData.append("Experience")
        pickerData.append("Courses")
        pickerData.append("Extracurriculars")
        //entryLabel.text = pickerData[0]
        setAlignment(row:0)
        loadSkills()
        loadCourses()
        
        
        //self.skillPicker.layer.cornerRadius = 20
        self.skillPicker.dataSource = self
        self.skillPicker.delegate = self
        
        
        
        //self.coursePicker.layer.cornerRadius = 20
        self.coursePicker.dataSource = self
        self.coursePicker.delegate = self
        
        
        
        
        entryType = pickerData[0]
        skillName.text = skillData[0]
       
        skillDescription.text = "Understanding the implications of new information for both current and future problem solving and decision making."
        //classList.isHidden = true
        //self.entryName.frame = CGRect(x: 126, y: 177, width: entryName.frame.width, height: entryName.frame.height)
        self.skillImage.layer.cornerRadius = skillImage.frame.width/2
        skillImage.clipsToBounds = true
        
        
        //self.skillDescription.layer.cornerRadius = 20
        skillDescription.clipsToBounds = true
        //self.jobDescription.layer.cornerRadius = 20
        jobDescription.clipsToBounds = true
        //self.courseDescription.layer.cornerRadius = 20
        courseDescription.clipsToBounds = true
        //self.extracurricularDescription.layer.cornerRadius = 20
        extracurricularDescription.clipsToBounds = true
        //self.skillDescription.layer.borderWidth = 4
        
        
        
        self.skillImage.image = #imageLiteral(resourceName: "chalkboard")
        
        skillDescription.text = ""
        jobDescription.text = ""
        courseDescription.text = ""
        extracurricularDescription.text = ""
        
        
        switch Device.size() {
        case .screen3_5Inch:  print("It's a 3.5 inch screen")
        case .screen4Inch:    print("It's a 4 inch screen")
        case .screen4_7Inch:
            print("It's a 4.7 inch screen")
            self.skillImage.frame = CGRect(x: 157, y: 379, width: 60, height: 60)
        case .screen5_5Inch:  print("It's a 5.5 inch screen")
            
            self.skillImage.frame = CGRect(x: 177, y: 407, width: 60, height: 60)
            self.skillImage.isHidden = true
        case .screen5_8Inch:  print("It's a 5.8 inch screen")
        case .screen7_9Inch:  print("It's a 7.9 inch screen")
        case .screen9_7Inch:  print("It's a 9.7 inch screen")
        case .screen12_9Inch: print("It's a 12.9 inch screen")
        default:              print("Unknown size")
        }
        
        
        jobDescription.layer.cornerRadius = 10
        skillDescription.layer.cornerRadius = 10
        skillPicker.layer.cornerRadius = 10
        
        
        courseDescription.layer.cornerRadius = 10
        coursePicker.layer.cornerRadius = 10
        
        extracurricularDescription.layer.cornerRadius = 10
    
        
    }
    
    
    override var preferredStatusBarStyle:UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    
    override var canBecomeFirstResponder:Bool {
        return true
    }
    
    
    // Function that is triggered if the phone is shaken
    // This acts like an etch-a sketch. If you shake the phone, it will prompt and ask if you wish to clear the present textviews and textfields.
    /// - Parameters:
    ///   - motion:  the motion type
    ///   - event: the event that triggers this function
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent!) {
        var alert = UIAlertController(title: "Clear Text??",
                                      message: "Are you sure you want to clear the text?",
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        
        
        
        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        
        subview.backgroundColor = UIColor(red:0.91, green:0.38, blue:0.50, alpha:1.0)
        alert.view.tintColor = .black
        
        
        
        
        alert.addAction(UIAlertAction(title: "Yes",
                                      style: UIAlertActionStyle.default, handler: self.clearText))
        alert.addAction(UIAlertAction(title: "No",
                                      style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // This function actually cclears the textfields/views
    func clearText(alert: UIAlertAction!){
        skillName.text = ""
        skillDescription.text = ""
        jobName.text = ""
        startYearEntry.text = ""
        endYearEntry.text = ""
        organizationNameEntry.text = ""
        contactNameEntry.text = ""
        jobDescription.text = ""
        courseNameEntry.text = ""
        courseDescription.text = ""
        extracurricularNameEntry.text = ""
        yearEntry.text = ""
        extracurricularDescription.text = ""
        
        
    }
   
    
    
    //Loads the courses into an array called coursedata
    //which is used as a datasource by coursePicker
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
    
    
    //Loads the skills into an array called skillData
    //which is used as a datasource by skillPicker
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
    
    
    // When save button is pressed the data is stored in the
    // coredata model by using datacontroller as an interface
    // - Parameter sender: the UIButton that triggers this function being called
    @IBAction func saveEntry(_ sender: UIButton){
        
        print("!!!" + entryType!)
        if(entryType == "Skill"){
            
            
            dataController.saveSkills(theSkills: "Skill" + "_" + skillName.text! + "_" + skillDescription.text)
        } else if(entryType == "Experience"){
            var experienceString =  "Professional Development" + "_" + jobName.text! + "_"
            experienceString += startYearEntry.text! + "_" + endYearEntry.text! + "_"
                
            experienceString += organizationNameEntry.text! + "_" + contactNameEntry.text!
            experienceString +=   "_" + jobDescription.text
            dataController.saveExperience(experience: experienceString)
        } else if(entryType == "Courses"){
            dataController.saveCourses(courses: "Courses" + "_" + courseNameEntry.text! + "_" + courseDescription.text)
        } else if(entryType == "Extracurriculars"){
            dataController.saveExtracurriculars(extracurricular: "Extracurriculars" + "_" + extracurricularNameEntry.text! + "_" + extracurricularDescription.text + "_" + yearEntry.text!)
        }
        infoController.saveChangeText(text: String(reloadCounter))
        reloadCounter += 1
        dismiss(animated: true, completion: nil)
    }
    
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //  The number of rows of data for the pickerViews
    //  Changes based on which pickerview is being passed in
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
       
        
        
        if pickerView == skillPicker{
            if(entryType == "Skill"){
                print("still ehre")
                return skillData.count
            }
        } else if pickerView == coursePicker{
            if(entryType == "Courses"){
                
                print("row size = coursedata")
                return courseData.count
            
            }
        }
         
       
        return 1
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        
        if pickerView == skillPicker{
            if(entryType == "Skill"){
                return skillData[row]
            }
        } else if pickerView == coursePicker{
            if(entryType == "Courses"){
                if(row <= courseData.count){
                    return courseData[row]
                }
            }
        }
        
        return " "
    }
    
    // Alters the UIPickers for courses and skills and changes their properties accordingly.
    // Configures coursePicker and SKillPicker when prsented
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if pickerView == skillPicker{
            if(entryType == "Skill"){
                skillImage.isHidden = false
                
                
                
                selectedItem = skillData[row]
                skillName.text = selectedItem
                self.skillImage.layer.cornerRadius = skillImage.frame.width/2
                skillImage.clipsToBounds = true
                setPicture(slectedItem: selectedItem)
                setDescriptions(slectedItem: selectedItem)
            }
        } else if pickerView == coursePicker{
            if(entryType == "Courses"){
                self.skillImage.image = UIImage()
                self.skillImage.isHidden = true
                selectedItem = courseData[row]
                courseNameEntry.text = selectedItem
                setClassDescriptions(orClass: selectedItem)
            }
        }
            
        
            
            
            
        
    }
    
    
    
    // Sets the textviews and fields for skills
    // For example, when the user selects active listening, this function updates the textview description
    // to reflect this selection
    // - Parameter slectedItem: the selected skill which is fed from the UIPICker
    func setDescriptions(slectedItem: String){
        if(selectedItem == "Active Learning"){
            skillDescription.text = "Understanding the implications of new information for both current and future problem solving and decision making."
            skillName.text = "Active Learning"
        } else if (selectedItem == "Active Listening"){
            skillDescription.text = "Giving full attention to what other people are saying, taking time to understand the points being made, asking questions as appropriate, and not interrupting at inappropriate times."
            skillName.text = "Active Listening"
        } else if (selectedItem == "Critical Thinking"){
            skillDescription.text = "Using logic and reasoning to identify the strengths and weaknesses of alternative solutions, conclusions or approaches to problems."
            skillName.text = "Critical Thinking"
        } else if (selectedItem == "Learning Strategies"){
            skillDescription.text = "Selecting and using training/instructional methods and procedures appropriate for the situation when learning or teaching new things."
            skillName.text = "Learning Strategies"
        } else if (selectedItem == "Mathematics"){
            skillDescription.text = "Using mathematics to solve problems."
            skillName.text = "Mathematics"
        } else if (selectedItem == "Monitoring"){
            skillDescription.text = "Monitoring/Assessing performance of yourself, other individuals, or organizations to make improvements or take corrective action."
            skillName.text = "Monitoring"
        } else if (selectedItem == "Reading Comprehension"){
            skillDescription.text = "Understanding written sentences and paragraphs in work related documents."
            skillName.text = "Reading Comprehension"
        } else if (selectedItem == "Science"){
            skillDescription.text = "Using scientific rules and methods to solve problems."
            skillName.text = "Science"
        } else if (selectedItem == "Speaking"){
            skillDescription.text =  "Talking to others to convey information effectively."
            skillName.text = "Speaking"
        } else if (selectedItem == "Writing"){
            skillDescription.text = "Communicating effectively in writing as appropriate for the needs of the audience."
            skillName.text = "Writing"
        }
        
         else if (selectedItem == "Complex Problem Solving"){
            skillDescription.text = "Identifying complex problems and reviewing related information to develop and evaluate options and implement solutions."
            skillName.text = "Complex Problem Solving"
         } else if (selectedItem == "Time Management"){
            skillDescription.text = "Managing one's own time and the time of others. "
            skillName.text = "Time Management"
         } else if (selectedItem == "Coordination"){
            skillDescription.text = "Adjusting actions in relation to others' actions. "
            skillName.text = "Coordination"
         } else if (selectedItem == "Instructing"){
            skillDescription.text =  "Teaching others how to do something."
            skillName.text = "Instructing"
         } else if (selectedItem == "Negotiation"){
            skillDescription.text = " Bringing others together and trying to reconcile differences. "
            skillName.text = "Negotiation"
         } else if (selectedItem == "Persuasion"){
            skillDescription.text = "Persuading others to change their minds or behavior. "
            skillName.text = "Persuasion"
         } else if (selectedItem == "Service Orientation"){
            skillDescription.text = "Actively looking for ways to help people. "
            skillName.text = "Service Orientation"
         } else if (selectedItem == "Social Perceptiveness"){
            skillDescription.text = "Being aware of others' reactions and understanding why they react as they do. "
            skillName.text = "Social Perceptiveness"
         } else if (selectedItem == "Judgment and Decision Making"){
            skillDescription.text = "Considering the relative costs and benefits of potential actions to choose the most appropriate one. "
            skillName.text = "Judgment and Decision Making"
        } else if (selectedItem == "Equipment Maintenance"){
            skillDescription.text = "Performing routine maintenance on equipment and determining when and what kind of maintenance is needed. "
            skillName.text = "Equipment Maintenance"
        } else if (selectedItem == "Equipment Selection"){
            skillDescription.text = "Determining the kind of tools and equipment needed to do a job. "
            skillName.text = "Equipment Selection"
        } else if (selectedItem == "Installation"){
            skillDescription.text = "Installing equipment, machines, wiring, or programs to meet specifications. "
            skillName.text = "Installation"
        } else if (selectedItem == "Operation and Control"){
            skillDescription.text = "Controlling operations of equipment or systems. "
            skillName.text = "Operation and Control"
        } else if (selectedItem == "Programming"){
            skillDescription.text = "Writing computer programs for various purposes. "
            skillName.text = "Programming"
        } else if (selectedItem == "Quality Control Analysis"){
            skillDescription.text = "Conducting tests and inspections of products, services, or processes to evaluate quality or performance. "
            skillName.text = "Quality Control Analysis"
        } else if (selectedItem == "Repairing"){
            skillDescription.text = "Repairing machines or systems using the needed tools. "
            skillName.text = "Repairing"
        } else if (selectedItem == "Technology Design"){
            skillDescription.text = "Generating or adapting equipment and technology to serve user needs. "
            skillName.text = "Technology Design"
        } else if (selectedItem == "Troubleshooting"){
            skillDescription.text = "Determining causes of operating errors and deciding what to do about it."
            skillName.text = "Troubleshooting"
        }
        
        let my = UIViewController()
        
        
        
    }
    
    
    // Sets the corresponding image for a skill.
    //
    // - Parameter slectedItem: the selected item being looked at
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
    
    // Sets the description for the class that is selected
    //
    // - Parameter orClass:  the name of the class being looked at
    func setClassDescriptions(orClass: String){
        if(orClass == "PSYCH 2103"){
            courseDescription.text = "Behavioral Psychology" + "\n"
        } else if (orClass == "MUSI 1202"){
            courseDescription.text = "Chorale" + "\n"
        } else if (orClass == "LMC 2500"){
            courseDescription.text = "Introduction to Film" + "\n"
        } else if (orClass == "SPAN 3823"){
            courseDescription.text = "Latin American Music" + "\n"
        } else if (orClass == "MGT 4192"){
            courseDescription.text = "IMPACT Forum" + "\n"
        } else if (orClass == "MGT 4193"){
            courseDescription.text = "Servant Leadership" + "\n"
        } else if (orClass == "APPH 1050"){
            courseDescription.text = "Applied Physiology with workout" + "\n"
        } else if (orClass == "PSYC 1101"){
            courseDescription.text = "General Psychology" + "\n"
        } else if (orClass == "LMC 2500"){
            courseDescription.text = "Introduction to Film" + "\n"
        } else if (orClass == "APPH 1040"){
            courseDescription.text = "Applied Physiology" + "\n"
        } else if (orClass == "SPAN 2001"){
            courseDescription.text = "Intermediate Spanish" + "\n"
        } else if (orClass == "HTS 2015"){
            courseDescription.text = "History of Sports" + "\n"
        } else if (orClass == "MGT2200"){
            courseDescription.text = "Information Technology" + "\n"
        } else if (orClass == "HIST 2112"){
            courseDescription.text = "American History  1877 to present" + "\n"
        } else if (orClass == "MUSI 1202"){
            courseDescription.text = "Chorale" + "\n"
        } else if (orClass == "PSYC 1101"){
            courseDescription.text = "General Psychology" + "\n"
        } else if (orClass == "MGT 4193"){
            courseDescription.text = "Servant Leadership" + "\n"
        } else if (orClass == "MUSI 3251"){
            courseDescription.text =  "Glee Club" + "\n"
        } else if (orClass == "HIST 2112"){
            courseDescription.text = "American History  1877 to present" + "\n"
        } else if (orClass == "LMC 3252"){
            courseDescription.text = "Film and Television" + "\n"
        } else if (orClass == "JAP 1001"){
            courseDescription.text = "Beginners Japaneese" + "\n"
        } else if (orClass == "PSYC 1101"){
            courseDescription.text = "General Psychology" + "\n"
        } else if (orClass == "LMC 2600"){
            courseDescription.text = "Intro to Performance Studies" + "\n"
        } else if (orClass == "SPAN 2001"){
            courseDescription.text = "Intermediate Spanish" + "\n"
        } else if (orClass == "LMC 2500"){
            courseDescription.text = "Introduction to Film" + "\n"
        } else if (orClass == "MGT 2200"){
            courseDescription.text = "Information Technology" + "\n"
        }
    }
    
    // If the back button is pressed it takes you to the view with the cards
    
    // - Parameter sender: the button that triggers the exit
    @IBAction func exit(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    //Sets up the gesture recognizers present in the swipecontroller.
    // Allows user to also swipe left or right to navigate between skills, extracurriculars, courses, and experience
    func setUpGestures(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        
        swipeRight.addTarget(self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        swipeRight.cancelsTouchesInView = false
        self.swipeController.addGestureRecognizer(swipeRight)
        //self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.cancelsTouchesInView = false
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.swipeController.addGestureRecognizer(swipeLeft)
        
    }
    
    var indx = 0
    
    
    //  Allows for right swipe/ button to navigate  navigate between skills, extracurriculars, courses, and experience
    // GOES RIGHT ONLY
    @IBAction func rightTap(_ sender: UIButton){
        indx += 1
        if (indx > (pickerData.count - 1)){
            indx = 0
        } else if (indx < 0) {
            indx = pickerData.count - 1
        }
        swipeControllerLabel.text = pickerData[indx]
        setAlignment(row: indx)
    }
    
    //  Allows for left swipe/ button to navigate  navigate between skills, extracurriculars, courses, and experience
    // GOES LEFT ONLY
    @IBAction func leftTap(_ sender: UIButton){
        indx += 1
        if (indx > (pickerData.count - 1)){
            indx = 0
        } else if (indx < 0) {
            indx = pickerData.count - 1
        }
        swipeControllerLabel.text = pickerData[indx]
        setAlignment(row: indx)
    }
    
    
    
    
    // Determines which direction is being swiped in the swipecontroller
    // - Parameter gesture: THe UIGesture that is tested to see if its direction is left/right
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
                swipeControllerLabel.text = pickerData[indx]
                setAlignment(row: indx)
                
            case UISwipeGestureRecognizerDirection.right:
                indx -= 1
                if (indx > (pickerData.count - 1)){
                    indx = 0
                } else if (indx < 0) {
                    indx = pickerData.count - 1
                }
                
                swipeControllerLabel.text = pickerData[indx]
                setAlignment(row: indx)
                
            default:
                break
            }
        }
    }
    
    
    // Determines which textviews and textfields or UIPIckers should be displayed based on the type of entry selected
    func setAlignment(row: Int){
        entryType = pickerData[row]
        print("the entry type is" +  entryType)
        if(entryType == "Skill"){
            skillView.isHidden = false
            self.view.bringSubview(toFront: skillView)
            
            self.jobView.isHidden = true
            self.courseView.isHidden = true
            self.extracurricularView.isHidden = true
            skillPicker.reloadAllComponents()
            skillPicker.isUserInteractionEnabled = true
           
            
            setDescriptions(slectedItem: entryType)
            setPicture(slectedItem: entryType)
            
            
            
            
            
        } else if(entryType == "Experience"){
            
            skillImage.isHidden = true
            jobView.isHidden = false
            self.view.bringSubview(toFront: jobView)
            
            self.skillView.isHidden = true
            self.courseView.isHidden = true
            self.extracurricularView.isHidden = true
            /*
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
            
            */
            
            
            
            
            
        }else if(entryType == "Courses") {
            
            
            skillImage.isHidden = true
            coursePicker.reloadAllComponents()
            skillImage.isHidden = true
            courseView.isHidden = false
            self.view.bringSubview(toFront: courseView)
            
            self.skillView.isHidden = true
            self.jobView.isHidden = true
            self.extracurricularView.isHidden = true
            
            /*
            classList.isHidden = false
            classNamePicker.isUserInteractionEnabled = true
            classList.isUserInteractionEnabled = true
            nameLabel.text = "Course Name"
            classNamesLabel.text = "Course"
            entryDescription.text = ""
            
            
            
            timelineView.isHidden = true
            companyView.isHidden = true
            contactView.isHidden = true
            yearReceivedView.isHidden = true
             */
            
        } else if(entryType == "Extracurriculars"){
            
            skillImage.isHidden = true
            extracurricularView.isHidden = false
            self.view.bringSubview(toFront: extracurricularView)
            
            self.skillView.isHidden = true
            self.jobView.isHidden = true
            self.courseView.isHidden = true
            
            /*
             
             
             
            entryName.text = " "
            entryDescription.text = ""
            classList.isHidden = true
            
            
            classNamesLabel.text = "Name:"
            classList.isUserInteractionEnabled = false
            classNamePicker.isUserInteractionEnabled = false
            yearReceivedView.isHidden = false
            yearLabel.text = "Year:"
            
            
            
            
            
            timelineView.isHidden = true
            companyView.isHidden = true
            contactView.isHidden = true
            classList.isHidden = true
            
            
            */
            
            
        }
        
        
    }
    
    
    @IBAction func dismissTheView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        
        
        
        view.endEditing(true)
        
        
    }
}

