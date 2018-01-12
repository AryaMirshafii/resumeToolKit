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
    
    
    
    
    func activateTaps(){
        print("activateTAPS is " + String(tapRecognizer.isEnabled))
        tapRecognizer.isEnabled = true
        
        
    }
    
    @objc func longPressed(_ sender: UILongPressGestureRecognizer){
        extracurricularDescription.isUserInteractionEnabled = true
        extracurricularDescription.becomeFirstResponder()
        originalText = self.getOriginalText()
        print("Pressing long")
        
    }
    
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
    
    
    override func getOriginalText() -> String {
        return "Extracurriculars" + "_" + extracurricularNameLabel.text! + "_" + extracurricularDescription.text + "_" + extracurricularYearLabel.text!
    }
    
    
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("longpressed")
        
        deleteInformation()
        
        tapRecognizer.isEnabled = false
        
    }
    private var reloadCounter = 0
    override func deleteInformation() {
        
        
        
        dataController.overwriteExtracurriculars(previousText:  "Extracurriculars" + "_" + extracurricularNameLabel.text! + "_" + extracurricularDescription.text + "_" + extracurricularYearLabel.text!, extraCurricularToReplace: "")
    
        
        infoController.saveChangeText(text: String(reloadCounter))
        reloadCounter += 1
        
    }
    
}
