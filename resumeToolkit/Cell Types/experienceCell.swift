//
//  experienceCell.swift
//  resumeWriterPro
//
//  Created by Arya Mirshafii on 1/1/18.
//  Copyright © 2018 georgiaTechEngineeringForInnovationGroup. All rights reserved.
//

import Foundation
class experienceCell:resumeCell {
    @IBOutlet weak var positionlabel: UILabel!
    @IBOutlet weak var startYearLabel: UILabel!
    @IBOutlet weak var endYearLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var experienceDescription: UITextView!
    @IBOutlet weak var contactLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor(red:0.23, green:0.42, blue:0.86, alpha:1.0)
        experienceDescription.backgroundColor = .clear
        self.tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tapRecognizer)
        tapRecognizer.isEnabled = false
        //tapRecognizer.disa
        print("CELL CREATED")
        experienceDescription.tintColor = .white
        experienceDescription.delegate = self
        experienceDescription.isUserInteractionEnabled = false
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(_:)))
        self.addGestureRecognizer(longPressRecognizer)
        experienceDescription.tintColor = .white
        
    }
    
    
    //Function is called when cell is toggled to be deleted
    //Allows the cell to be tapped, which allows the user to tap the delete button
    //on the cell
    
    
    func activateTaps(){
        print("activateTAPS is " + String(tapRecognizer.isEnabled))
        tapRecognizer.isEnabled = true
        
        
        
    }
    
    
    //WHen the user swipes to the right on this cell, it shows the delete function
    // this function is run when the delete button is pressed.
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("longpressed")
        
        deleteInformation()
        
        tapRecognizer.isEnabled = false
        
    }
    
    
    //Enables editing of the cell.
    //Lets say you mispell something, you can go back and edit it without re entering it.
    
    @objc func longPressed(_ sender: UILongPressGestureRecognizer){
        experienceDescription.isUserInteractionEnabled = true
        experienceDescription.becomeFirstResponder()
        originalText = self.getOriginalText()
        print("Pressing long")
        
    }
    
    
    //Saves changes in the coredata model
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            experienceDescription.isUserInteractionEnabled = false
            experienceDescription.resignFirstResponder()
            var experienceString =  "Professional Development" + "_" + positionlabel.text! + "_"
            experienceString += startYearLabel.text! + "_" + endYearLabel.text! + "_"
            
            experienceString += companyLabel.text! + "_" + contactLabel.text!
            experienceString +=   "_" + experienceDescription.text
            dataController.overwriteExperience(previousText: originalText, experienceToChangeTo: experienceString)
            reloadCounter += 1
            infoController.saveChangeText(text: String(reloadCounter))
            
            return false
        }
        return true
    }
    
    //  Gets the original text entered in the text fields and textviews
    //  Used when updating the coredata model
    //
    //
    //- Returns: the original text.
    override func getOriginalText() -> String {
        var experienceString =  "Professional Development" + "_" + positionlabel.text! + "_"
        experienceString += startYearLabel.text! + "_" + endYearLabel.text! + "_"
        
        experienceString += companyLabel.text! + "_" + contactLabel.text!
        experienceString +=   "_" + experienceDescription.text
        return experienceString
    }
    
    
    // Triggers the overwrite method in datacontroller and passes in an empty string
    // This empty string is the equivalent of deleting the cell.
    // Reload counter is used to trigger the functions in other files that cause the data to be reloaded.
    // An example of this would be deleting a course and then having the pdf generating viewcontroller
    // update the contents of the pdf to reflect this change.
    
    private var reloadCounter = 0
    override func deleteInformation() {
        
        var experienceString =  "Professional Development" + "_" + positionlabel.text! + "_"
        experienceString += startYearLabel.text! + "_" + endYearLabel.text! + "_"
        
        experienceString += companyLabel.text! + "_" + contactLabel.text!
        experienceString +=   "_" + experienceDescription.text
        
        dataController.overwriteExperience(previousText: experienceString, experienceToChangeTo: "")
        
        
        infoController.saveChangeText(text: String(reloadCounter))
        reloadCounter += 1
        
    }
    
    
}
