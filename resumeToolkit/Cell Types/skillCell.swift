//
//  skillCell.swift
//  resumeWriterPro
//
//  Created by Arya Mirshafii on 1/1/18.
//  Copyright © 2018 georgiaTechEngineeringForInnovationGroup. All rights reserved.
//

import Foundation
import CoreData
import EasyTipView
class skillCell: resumeCell,EasyTipViewDelegate{
    func easyTipViewDidDismiss(_ tipView: EasyTipView) {
        
    }
    
    @IBOutlet weak var skillNameLabel: UILabel!
    @IBOutlet weak var skillDescription: UITextView!
    
    private var tipView:EasyTipView!
    
    
    
    
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
        print("Created a skill cell!")
        
    }
    
    
    
    //Function is called when cell is toggled to be deleted
    //Allows the cell to be tapped, which allows the user to tap the delete button
    //on the cell
    func activateTaps(){
        print("activateTAPS is " + String(tapRecognizer.isEnabled))
        tapRecognizer.isEnabled = true
        
        
    }
    
    
    //Enables editing of the cell.
    //Lets say you mispell something, you can go back and edit it without re entering it.
    @objc func longPressed(_ sender: UILongPressGestureRecognizer){
        skillDescription.isUserInteractionEnabled = true
        skillDescription.becomeFirstResponder()
        skillDescription.showsVerticalScrollIndicator = true
        originalText = self.getOriginalText()
        print("Pressing long")
        
    }
    
    
    //Saves changes in the coredata model
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            skillDescription.isUserInteractionEnabled = false
            skillDescription.resignFirstResponder()
            dataController.overwriteSkill(name: self.skillNameLabel.text!, updatedDescription: self.skillDescription.text)
            
            reloadCounter += 1
            infoController.saveChangeText(text: String(reloadCounter))
            skillDescription.showsVerticalScrollIndicator = false
            
            return false
        }
        return true
    }
    
    
    
    //  Gets the original text in the courseDescription textfield
    //  Used when updating the coredata model
    //
    //
    //- Returns: the original text.
    override func getOriginalText() -> String {
        return "Skill" + "_" + self.skillNameLabel.text! + "_" + self.skillDescription.text
    }
    
    
    
    
    //WHen the user swipes to the right on this cell, it shows the delete function
    // this function is run when the delete button is pressed.
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("longpressed")
        
        deleteInformation()
        
        tapRecognizer.isEnabled = false
        
    }
    
    
    
    // Triggers the overwrite method in datacontroller and passes in an empty string
    // This empty string is the equivalent of deleting the cell.
    // Reload counter is used to trigger the functions in other files that cause the data to be reloaded.
    // An example of this would be deleting a course and then having the pdf generating viewcontroller
    // update the contents of the pdf to reflect this change.
    var reloadCounter = 0
    override func deleteInformation() {
        print("Updating skill")
        //dataController.overwriteSkill(name:self.skillNameLabel.text! , updatedDescription: self.skillDescription.text)
        dataController.deleteSkill(name: self.skillNameLabel.text!)
        //dataController.overwriteSkill(previousText: "Skill" + "_" + self.skillNameLabel.text! + "_" + self.skillDescription.text, textToChangeTo: "")
            //self.originalSkillText = "Skill" + "_" + entryName.text! + "_" + entryDescription.text
        
        infoController.saveChangeText(text: String(reloadCounter))
        reloadCounter += 1
        
    }
    
}
