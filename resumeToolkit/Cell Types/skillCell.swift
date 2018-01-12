//
//  skillCell.swift
//  resumeWriterPro
//
//  Created by Arya Mirshafii on 1/1/18.
//  Copyright © 2018 georgiaTechEngineeringForInnovationGroup. All rights reserved.
//

import Foundation
import CoreData
class skillCell: resumeCell{
    @IBOutlet weak var skillNameLabel: UILabel!
    @IBOutlet weak var skillDescription: UITextView!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor(red:0.82, green:0.65, blue:0.06, alpha:1.0)
        self.tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tapRecognizer)
        tapRecognizer.isEnabled = false
        skillDescription.delegate = self
        skillDescription.isUserInteractionEnabled = false
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(_:)))
        self.addGestureRecognizer(longPressRecognizer)
        skillDescription.tintColor = .white
        //tapRecognizer.disa
        print("CELL CREATED")
        
    }
    
    
    func activateTaps(){
        print("activateTAPS is " + String(tapRecognizer.isEnabled))
        tapRecognizer.isEnabled = true
        
       
        
        
        
    }
    
    @objc func longPressed(_ sender: UILongPressGestureRecognizer){
        skillDescription.isUserInteractionEnabled = true
        skillDescription.becomeFirstResponder()
        skillDescription.showsVerticalScrollIndicator = true
        originalText = self.getOriginalText()
        print("Pressing long")
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            skillDescription.isUserInteractionEnabled = false
            skillDescription.resignFirstResponder()
            dataController.overwriteSkill(previousText: originalText, textToChangeTo: "Skill" + "_" + self.skillNameLabel.text! + "_" + self.skillDescription.text)
            reloadCounter += 1
            infoController.saveChangeText(text: String(reloadCounter))
            skillDescription.showsVerticalScrollIndicator = false
            
            return false
        }
        return true
    }
    
    
    override func getOriginalText() -> String {
        return "Skill" + "_" + self.skillNameLabel.text! + "_" + self.skillDescription.text
    }
    
    
    
    
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("longpressed")
        
        deleteInformation()
        
        tapRecognizer.isEnabled = false
        
    }
    
    
    
    
    var reloadCounter = 0
    override func deleteInformation() {
        
            
            
        dataController.overwriteSkill(previousText: "Skill" + "_" + self.skillNameLabel.text! + "_" + self.skillDescription.text, textToChangeTo: "")
            //self.originalSkillText = "Skill" + "_" + entryName.text! + "_" + entryDescription.text
        
        infoController.saveChangeText(text: String(reloadCounter))
        reloadCounter += 1
        
    }
    
}
