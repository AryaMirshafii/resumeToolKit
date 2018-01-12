//
//  resumeItemCell.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 12/10/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit

class resumeItemCell:UITableViewCell,UITextFieldDelegate,UITextViewDelegate {
    
    @IBOutlet weak var entryDescriptionField: UITextView!
    @IBOutlet weak var itemNameLabel: UILabel!
    
    
    
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var cellType = " "
    var originalText = " "
    
    var dataController = dataManager()
    var infoController = userInfo()
     override func awakeFromNib() {
        self.entryDescriptionField.layer.cornerRadius = 10
        
        entryDescriptionField.delegate = self
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(_:)))
        self.addGestureRecognizer(longPressRecognizer)
        //self.entryDescriptionField.addGestureRecognizer(longPressRecognizer)
        self.entryDescriptionField.isEditable = false
        self.saveButton.isHidden = true
        self.cancelButton.isHidden = true
    }
    
    
    @objc func longPressed(_ sender: UILongPressGestureRecognizer)
    {
        
        
        if(sender.state == .began){
            print("longpressed")
            if(self.cellType != "Internships & Job Experience"){
                self.entryDescriptionField.isUserInteractionEnabled = true
                self.saveButton.isHidden = false
                self.cancelButton.isHidden = false
                self.entryDescriptionField.isEditable = true
                self.entryDescriptionField.becomeFirstResponder()
                self.originalText =  getOriginalText()
                //entryDescriptionField.backgroundColor = UIColor(red:0.36, green:0.35, blue:0.35, alpha:1.0)
            }
            
        }
    }
    
    
    
    func getOriginalText() -> String {
        if(self.cellType == "Skill"){
            return "Skills" + "_" + itemNameLabel.text! + "_" + entryDescriptionField.text
            
            
        } else if(self.cellType == "Internships & Job Experience"){
            
            return " "
        } else if(self.cellType == "Courses"){
            return "Courses" + "_" + itemNameLabel.text! + "_" + entryDescriptionField.text
        } else if(self.cellType == "Extracurriculars"){
            return "Extracurriculars" + "_" + itemNameLabel.text! + "_" + entryDescriptionField.text
        }
        return "this didnt work"
    }
    
    
    @IBAction func cancelEntry(_ sender: Any) {
        self.saveButton.isHidden = true
        self.cancelButton.isHidden = true
        self.entryDescriptionField.endEditing(true)
        self.entryDescriptionField.isUserInteractionEnabled = false
        
        
    }
    
    
    var reloadCounter = 0
    @IBAction func saveEntry(_ sender: Any) {
        if(self.cellType == "Skills"){
            
            
            dataController.overwriteSkill(previousText: originalText, textToChangeTo: "Skills" + "_" + self.itemNameLabel.text! + "_" + self.entryDescriptionField.text)
            //self.originalSkillText = "Skill" + "_" + entryName.text! + "_" + entryDescription.text
        } else if(self.cellType == "Internships & Job Experience"){
            
            //dataController.saveExperience(experience: experienceString)
        } else if(self.cellType == "Courses"){
            dataController.overwriteCourses(previousText: originalText,courseToChangeTo: "Courses" + "_" + itemNameLabel.text! + "_" + entryDescriptionField.text)
        } else if(self.cellType == "Extracurriculars"){
            dataController.overwriteExtracurriculars(previousText: originalText, extraCurricularToReplace: "Extracurriculars" + "_" + itemNameLabel.text! + "_" + entryDescriptionField.text)
        }
        self.saveButton.isHidden = true
        self.cancelButton.isHidden = true
        self.entryDescriptionField.endEditing(true)
        self.entryDescriptionField.isUserInteractionEnabled = false
        //self.entryDescriptionField.backgroundColor = self.originalColor
        infoController.saveChangeText(text: String(reloadCounter))
        reloadCounter += 1
        
    }
    
}
