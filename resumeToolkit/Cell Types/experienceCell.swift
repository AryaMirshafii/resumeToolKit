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
    
    func activateTaps(){
        print("activateTAPS is " + String(tapRecognizer.isEnabled))
        tapRecognizer.isEnabled = true
        
        
        
    }
    
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("longpressed")
        
        deleteInformation()
        
        tapRecognizer.isEnabled = false
        
    }
    
    
    
    @objc func longPressed(_ sender: UILongPressGestureRecognizer){
        experienceDescription.isUserInteractionEnabled = true
        experienceDescription.becomeFirstResponder()
        originalText = self.getOriginalText()
        print("Pressing long")
        
    }
    
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
    
    
    override func getOriginalText() -> String {
        var experienceString =  "Professional Development" + "_" + positionlabel.text! + "_"
        experienceString += startYearLabel.text! + "_" + endYearLabel.text! + "_"
        
        experienceString += companyLabel.text! + "_" + contactLabel.text!
        experienceString +=   "_" + experienceDescription.text
        return experienceString
    }
    
    
    
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
