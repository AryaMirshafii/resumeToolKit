//
//  secondLoginScreen.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/6/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit

class secondLoginScreen: UIViewController, UITextFieldDelegate  {
    @IBOutlet weak var phoneEntry: UITextField!
    @IBOutlet weak var currentSchoolEntry: UITextField!
    @IBOutlet weak var gradeLevelEntry: UITextField!
    
    @IBOutlet weak var doneButton: UIButton!
    
    
    
    
    
    
    var dataController = dataManager()
    var infoController = userInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        
        
        self.phoneEntry.delegate = self
        self.phoneEntry.clearButtonMode = .whileEditing
        self.phoneEntry.layer.cornerRadius = self.phoneEntry.frame.height/2
        phoneEntry.layer.borderWidth = 2
        phoneEntry.layer.borderColor = UIColor(red:0.00, green:0.40, blue:0.80, alpha:1.0).cgColor
        phoneEntry.clipsToBounds = true
        
        
        
        self.currentSchoolEntry.delegate = self
        self.currentSchoolEntry.clearButtonMode = .whileEditing
        self.currentSchoolEntry.layer.cornerRadius = self.currentSchoolEntry.frame.height/2
        currentSchoolEntry.layer.borderWidth = 2
        currentSchoolEntry.layer.borderColor = UIColor(red:0.00, green:0.40, blue:0.80, alpha:1.0).cgColor
        currentSchoolEntry.clipsToBounds = true
        
        
        
        
        
        
        
        
        
        
        
        
        self.gradeLevelEntry.delegate = self
        self.gradeLevelEntry.clearButtonMode = .whileEditing
        self.gradeLevelEntry.layer.cornerRadius = self.gradeLevelEntry.frame.height/2
        gradeLevelEntry.layer.borderWidth = 2
        gradeLevelEntry.layer.borderColor = UIColor(red:0.00, green:0.40, blue:0.80, alpha:1.0).cgColor
        gradeLevelEntry.clipsToBounds = true
        
        
        
        
        
        
        
        
        doneButton.frame = CGRect(x: (view.frame.width - doneButton.frame.width)/2, y:  390, width: doneButton.frame.width, height: doneButton.frame.height)
       
        
        //UNCOMMENT
        
        doneButton.layer.backgroundColor = UIColor(red:0.00, green:0.40, blue:0.80, alpha:1.0).cgColor
        self.doneButton.layer.cornerRadius = self.doneButton.frame.height/2
        doneButton.clipsToBounds = true
        
        
       currentSchoolEntry.text = "Georgia Tech Excel Program"
    }
    
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return pressed on second screen")
        
        dataController.savePhoneNumber(phoneNumber: phoneEntry.text!)
        dataController.saveSchool(schoolName: currentSchoolEntry.text!)
        dataController.saveGradeLevel(gradeLevel: gradeLevelEntry.text!)
        textField.resignFirstResponder()
        return false
    }
    
    
    @IBAction func returnHome(_ sender: UIButton){
        dataController.savePhoneNumber(phoneNumber: phoneEntry.text!)
        dataController.saveSchool(schoolName: currentSchoolEntry.text!)
        dataController.saveGradeLevel(gradeLevel: gradeLevelEntry.text!)
        infoController.save(screen: "main")
       
        dismiss(animated: true, completion: nil)
    }
    
}
