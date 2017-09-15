//
//  editViewController.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/7/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit


class editViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    let dataController = dataManager()
    
    @IBOutlet weak var entryPicker: UIPickerView!
    @IBOutlet weak var entryName: UITextField!
    @IBOutlet weak var entryDescription: UITextView!
    @IBOutlet weak var classList: UIView!
    
    @IBOutlet weak var nameView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
     @IBOutlet weak var classNamePicker: UIPickerView!
    
    
    @IBOutlet weak var classNamesLabel: UILabel!
    
    var pickerData: [String] = [String]()
    var entryType: String!
    
    var infoController = userInfo()
    
    var skillData: [String] = [String]()
    var selectedItem = " "
    
    var reloadCounter = 0
    var previousSkill = " "
    override func viewDidLoad() {
        super.viewDidLoad()
        entryDescription.text  = " "
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        
        
        pickerData.append("Skill")
        pickerData.append("Experience")
        pickerData.append("Courses")
        loadSkills()
        
        self.entryPicker.delegate = self
        self.entryPicker.dataSource = self
        self.entryPicker.layer.cornerRadius = 20
        self.classNamePicker.layer.cornerRadius = 20
        
        self.classNamePicker.dataSource = self
        self.classNamePicker.delegate = self
        
        
        
        
        entryType = pickerData[0]
        entryName.text = skillData[0]
        nameLabel.text = "Skill Name:"
        entryDescription.text = "Understanding the implications of new information for both current and future problem-solving and decision-making."
        //classList.isHidden = true
        //self.entryName.frame = CGRect(x: 126, y: 177, width: entryName.frame.width, height: entryName.frame.height)
        
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
            
            dataController.saveSkills(skills: "Skill" + "_" + entryName.text! + "_" + entryDescription.text)
        } else if(entryType == "Experience"){
            
            dataController.saveExperience(experience: "Experience" + "_" + entryName.text! + "_" + entryDescription.text)
        } else if(entryType == "Course"){
            dataController.saveCourses(courses: "Course" + "_" + entryName.text! + "_" + entryDescription.text)
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
        
        
        if pickerView == entryPicker {
            return pickerData.count
        } else if pickerView == classNamePicker{
            return skillData.count
        }
        return 1
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView == entryPicker {
            return pickerData[row]
        } else if pickerView == classNamePicker{
            return skillData[row]
        }
        
        return " "
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if pickerView == entryPicker {
            entryType = pickerData[row]
            if(entryType == "Skill"){
                
                classList.isHidden = false
                nameLabel.text = "Skill Name:"
                classList.frame = CGRect(x: 25, y: 161, width: classList.frame.width, height: classList.frame.height)
                nameView.frame = CGRect(x: 25, y: 296, width: nameView.frame.width, height: nameView.frame.height)
                setDescriptions(slectedItem: previousSkill)
            } else if(entryType == "Experience"){
                
                entryName.text = " "
                entryDescription.text = ""
                classList.isHidden = true
                nameView.frame = CGRect(x: 25, y: 161, width: nameView.frame.width, height: nameView.frame.height)
                nameLabel.text = "Experience Name:"
            }else {
                classList.isHidden = false
                
            }
        } else if pickerView == classNamePicker {
            selectedItem = skillData[row]
            previousSkill = selectedItem
            entryName.text = selectedItem
            setDescriptions(slectedItem: selectedItem)
            
            
        }
    }
    
    func setDescriptions(slectedItem: String){
        if(selectedItem == "Active Learning"){
            entryDescription.text = "Understanding the implications of new information for both current and future problem-solving and decision-making."
        } else if (selectedItem == "Active Listening"){
            entryDescription.text = "Giving full attention to what other people are saying, taking time to understand the points being made, asking questions as appropriate, and not interrupting at inappropriate times."
        } else if (selectedItem == "Critical Thinking"){
            entryDescription.text = "Using logic and reasoning to identify the strengths and weaknesses of alternative solutions, conclusions or approaches to problems."
        } else if (selectedItem == "Learning Strategies"){
            entryDescription.text = "Selecting and using training/instructional methods and procedures appropriate for the situation when learning or teaching new things."
        } else if (selectedItem == "Mathematics"){
            entryDescription.text = "Using mathematics to solve problems."
        } else if (selectedItem == "Monitoring"){
            entryDescription.text = "Monitoring/Assessing performance of yourself, other individuals, or organizations to make improvements or take corrective action."
        } else if (selectedItem == "Reading Comprehension"){
            entryDescription.text = "Understanding written sentences and paragraphs in work related documents."
        } else if (selectedItem == "Science"){
            entryDescription.text = "Using scientific rules and methods to solve problems."
        } else if (selectedItem == "Speaking"){
            entryDescription.text =  "Talking to others to convey information effectively."
        } else if (selectedItem == "Writing"){
            entryDescription.text = "Communicating effectively in writing as appropriate for the needs of the audience."
        }
        /**
         else if (selectedItem == skillData[10]){
         entryDescription.text
         } else if (selectedItem == skillData[11]){
         entryDescription.text
         } else if (selectedItem == skillData[12]){
         entryDescription.text
         } else if (selectedItem == skillData[13]){
         entryDescription.text
         } else if (selectedItem == skillData[14]){
         entryDescription.text
         } else if (selectedItem == skillData[15]){
         entryDescription.text
         } else if (selectedItem == skillData[16]){
         entryDescription.text
         } else if (selectedItem == skillData[17]){
         entryDescription.text
         } else if (selectedItem == skillData[18]){
         
         }
         */
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        
        
        
        view.endEditing(true)
        
        
    }
}
