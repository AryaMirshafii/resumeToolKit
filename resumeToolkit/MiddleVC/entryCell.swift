//
//  entryCell.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/7/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit
class entryCell : UITableViewCell,UITextViewDelegate{
    
    
    @IBOutlet weak var entryName: UILabel!
    
    @IBOutlet weak var entryDescription: UITextView!
   
    @IBOutlet weak var colorView: UIView!
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    var cellType:String!
    
    var dataController = dataManager()
    var infoController = userInfo()
    var originalText = ""
    var originalColor: UIColor!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.entryName.textColor = UIColor(red:0.00, green:0.40, blue:0.80, alpha:1.0)
        self.entryDescription.isUserInteractionEnabled = false
        self.layer.borderWidth = 20
        self.layer.borderColor = UIColor.clear.cgColor
        self.entryDescription.backgroundColor = UIColor(red:0.77, green:0.79, blue:0.83, alpha:1.0)
        
        entryDescription.delegate = self
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(_:)))
        self.addGestureRecognizer(longPressRecognizer)
        self.saveButton.isHidden = true
        self.cancelButton.isHidden = true
        self.originalColor = entryDescription.backgroundColor!
    }
    
    
    
    @objc func longPressed(_ sender: UILongPressGestureRecognizer)
    {
    
        
        if(sender.state == .began){
            print("longpressed")
            if(self.cellType != "Internships & Job Experience"){
                self.entryDescription.isUserInteractionEnabled = true
                self.saveButton.isHidden = false
                self.cancelButton.isHidden = false
                self.entryDescription.becomeFirstResponder()
                self.originalText =  getOriginalText()
                entryDescription.backgroundColor = UIColor(red:0.36, green:0.35, blue:0.35, alpha:1.0)
            }
            
        }
    }
    
    func getOriginalText() -> String {
        if(self.cellType == "Skill"){
            return "Skill" + "_" + entryName.text! + "_" + entryDescription.text
            
            
        } else if(self.cellType == "Internships & Job Experience"){
            
            return " "
        } else if(self.cellType == "Courses"){
            return "Courses" + "_" + entryName.text! + "_" + entryDescription.text
        } else if(self.cellType == "Extracurriculars"){
            return "Extracurriculars" + "_" + entryName.text! + "_" + entryDescription.text
        }
        return "this didnt work"
    }
    
    
    
    
    @IBAction func cancelEntry(_ sender: Any) {
        self.saveButton.isHidden = true
        self.cancelButton.isHidden = true
        self.entryDescription.endEditing(true)
        self.entryDescription.isUserInteractionEnabled = false
        self.entryDescription.backgroundColor = self.originalColor
        
    }
    
    var reloadCounter = 0
    @IBAction func saveEntry(_ sender: Any) {
        if(self.cellType == "Skill"){
            
            
            dataController.overwriteSkill(previousText: originalText, skillName: "Skill" + "_" + self.entryName.text! + "_" + self.entryDescription.text)
            //self.originalSkillText = "Skill" + "_" + entryName.text! + "_" + entryDescription.text
        } else if(self.cellType == "Internships & Job Experience"){
            
            //dataController.saveExperience(experience: experienceString)
        } else if(self.cellType == "Courses"){
            dataController.overwriteCourses(previousText: originalText,courseName: "Courses" + "_" + entryName.text! + "_" + entryDescription.text)
        } else if(self.cellType == "Extracurriculars"){
            dataController.overwriteExtracurriculars(previousText: originalText, extracurricularName: "Extracurriculars" + "_" + entryName.text! + "_" + entryDescription.text)
        }
        self.saveButton.isHidden = true
        self.cancelButton.isHidden = true
        self.entryDescription.endEditing(true)
        self.entryDescription.isUserInteractionEnabled = false
        self.entryDescription.backgroundColor = self.originalColor
        infoController.saveChangeText(text: String(reloadCounter))
        reloadCounter += 1
        
    }
    func getColor(aNumber: Int){
        
       
        if(aNumber == 0){
            colorView.backgroundColor = UIColor(red:0.23, green:0.42, blue:0.86, alpha:1.0)
            saveButton.setTitleColor(UIColor(red:0.23, green:0.42, blue:0.86, alpha:1.0), for: .normal)
            cancelButton.setTitleColor(UIColor(red:0.23, green:0.42, blue:0.86, alpha:1.0), for: .normal)
        }
        if(aNumber == 1){
            colorView.backgroundColor = UIColor(red:0.71, green:0.38, blue:0.50, alpha:1.0)
            saveButton.setTitleColor(UIColor(red:0.71, green:0.38, blue:0.50, alpha:1.0), for: .normal)
            cancelButton.setTitleColor(UIColor(red:0.71, green:0.38, blue:0.50, alpha:1.0), for: .normal)
        }
        if(aNumber == 2){
            colorView.backgroundColor = UIColor(red:0.15, green:0.62, blue:0.11, alpha:1.0)
            saveButton.setTitleColor(UIColor(red:0.15, green:0.62, blue:0.11, alpha:1.0), for: .normal)
            cancelButton.setTitleColor(UIColor(red:0.15, green:0.62, blue:0.11, alpha:1.0), for: .normal)
        }
    }
}
