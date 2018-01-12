//
//  courseCell.swift
//  resumeWriterPro
//
//  Created by Arya Mirshafii on 1/1/18.
//  Copyright © 2018 georgiaTechEngineeringForInnovationGroup. All rights reserved.
//

import Foundation
class courseCell:resumeCell{
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseDescription: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       self.contentView.backgroundColor = UIColor(red:0.71, green:0.38, blue:0.50, alpha:1.0)
        self.tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tapRecognizer)
        tapRecognizer.isEnabled = false
        courseDescription.delegate = self
        courseDescription.isUserInteractionEnabled = false
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(_:)))
        self.addGestureRecognizer(longPressRecognizer)
        //tapRecognizer.disa
        print("CELL CREATED")
        courseDescription.tintColor = .white
    }
    
    func activateTaps(){
        print("activateTAPS is " + String(tapRecognizer.isEnabled))
        tapRecognizer.isEnabled = true
        
        
        
    }
    
    
    @objc func longPressed(_ sender: UILongPressGestureRecognizer){
        courseDescription.isUserInteractionEnabled = true
        courseDescription.becomeFirstResponder()
        originalText = self.getOriginalText()
        print("Pressing long")
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            courseDescription.isUserInteractionEnabled = false
            courseDescription.resignFirstResponder()
            dataController.overwriteCourses(previousText: originalText, courseToChangeTo: "Courses" + "_" + courseNameLabel.text! + "_" + courseDescription.text)
            reloadCounter += 1
            infoController.saveChangeText(text: String(reloadCounter))
            
            return false
        }
        return true
    }
    
    
    override func getOriginalText() -> String {
        return "Courses" + "_" + courseNameLabel.text! + "_" + courseDescription.text
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("longpressed")
        
        deleteInformation()
        
        tapRecognizer.isEnabled = false
        
    }
    
    private var reloadCounter = 0
    override func deleteInformation() {
        
        dataController.overwriteCourses(previousText: "Courses" + "_" + courseNameLabel.text! + "_" + courseDescription.text, courseToChangeTo: "")
        
        
        
        infoController.saveChangeText(text: String(reloadCounter))
        reloadCounter += 1
        
    }
    
}
