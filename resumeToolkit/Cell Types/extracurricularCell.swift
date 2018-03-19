//
//  extracurricularCell.swift
//  resumeWriterPro
//
//  Created by Arya Mirshafii on 1/1/18.
//  Copyright © 2018 georgiaTechEngineeringForInnovationGroup. All rights reserved.
//

import Foundation

class extracurricularCell:resumeCell {
    
    @IBOutlet weak var extracurricularNameLabel: UILabel!
    @IBOutlet weak var extracurricularDescription: UITextView!
    @IBOutlet weak var extracurricularYearLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor(red:0.15, green:0.62, blue:0.11, alpha:1.0)
        self.tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tapRecognizer)
        tapRecognizer.isEnabled = false
        //tapRecognizer.disa
        print("CELL CREATED")
        extracurricularDescription.delegate = self
        extracurricularDescription.isUserInteractionEnabled = false
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(_:)))
        self.addGestureRecognizer(longPressRecognizer)
        extracurricularDescription.tintColor = .white
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
        extracurricularDescription.isUserInteractionEnabled = true
        extracurricularDescription.becomeFirstResponder()
        originalText = self.getOriginalText()
        print("Pressing long")
        
    }
    
    //Saves changes in the coredata model
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            extracurricularDescription.isUserInteractionEnabled = false
            extracurricularDescription.resignFirstResponder()
            dataController.overwriteSkill(previousText: originalText, textToChangeTo: "Extracurriculars" + "_" + extracurricularNameLabel.text! + "_" + extracurricularDescription.text + "_" + extracurricularYearLabel.text!)
            reloadCounter += 1
            infoController.saveChangeText(text: String(reloadCounter))
            
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
        return "Extracurriculars" + "_" + extracurricularNameLabel.text! + "_" + extracurricularDescription.text + "_" + extracurricularYearLabel.text!
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
    private var reloadCounter = 0
    override func deleteInformation() {
        
        
        
        dataController.overwriteExtracurriculars(previousText:  "Extracurriculars" + "_" + extracurricularNameLabel.text! + "_" + extracurricularDescription.text + "_" + extracurricularYearLabel.text!, extraCurricularToReplace: "")
    
        
        infoController.saveChangeText(text: String(reloadCounter))
        reloadCounter += 1
        
    }
    
}
