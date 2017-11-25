//
//  secondLoginScreen.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/6/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit
import Device_swift
class secondLoginScreen: UIViewController, UITextFieldDelegate  {
    @IBOutlet weak var phoneEntry: UITextField!
    @IBOutlet weak var currentSchoolEntry: UITextField!
    
    
    @IBOutlet weak var doneButton: UIButton!
    
    
    
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var schoolLabel: UILabel!
    
    
    
    
    
    var dataController = dataManager()
    var infoController = userInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getID()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        
        
        self.phoneEntry.delegate = self
        self.phoneEntry.clearButtonMode = .whileEditing
        /**
        self.phoneEntry.layer.cornerRadius = self.phoneEntry.frame.height/2
        phoneEntry.layer.borderWidth = 2
        phoneEntry.layer.borderColor = UIColor(red:0.00, green:0.40, blue:0.80, alpha:1.0).cgColor
        phoneEntry.clipsToBounds = true
         */
        
        
        
        self.currentSchoolEntry.delegate = self
        self.currentSchoolEntry.clearButtonMode = .whileEditing
        /**
        self.currentSchoolEntry.layer.cornerRadius = self.currentSchoolEntry.frame.height/2
        currentSchoolEntry.layer.borderWidth = 2
        currentSchoolEntry.layer.borderColor = UIColor(red:0.00, green:0.40, blue:0.80, alpha:1.0).cgColor
        currentSchoolEntry.clipsToBounds = true
         */
        
        
        
        
        
        
        
        
        
        
        
       
        
        
        
        
        
        
        
        
       
        
        //UNCOMMENT
        
        //doneButton.layer.backgroundColor = UIColor(red:0.00, green:0.40, blue:0.80, alpha:1.0).cgColor
        self.doneButton.layer.cornerRadius = self.doneButton.frame.height/2
        doneButton.clipsToBounds = true
        
        
        
       currentSchoolEntry.text = "Georgia Tech Excel Program"
        
        
        let deviceType = UIDevice.current.deviceType
        
        
    }
    
    
    
    
    func getID(){
        let deviceType = UIDevice.current.deviceType
        
        switch deviceType {
        case .iPhone5: positionViews(deviceID: "iphone5")
        case .iPadMini: print("Do stuff for iPad mini")
        default: print("Check other available cases of DeviceType")
        }
    }
    
    func positionViews(deviceID: String) {
        if(deviceID == "iphone5"){
            self.phoneNumberLabel.font = UIFont(name: "Prime-Regular", size: 18)
            self.schoolLabel.font = UIFont(name: "Prime-Regular", size: 18)
            
            
            self.phoneNumberLabel.frame = CGRect(x: 11, y: 34, width: 298, height: 32)
            self.phoneEntry.frame = CGRect(x: 76, y: 64, width: 169, height: 30)
            
            
            self.schoolLabel.frame = CGRect(x: 11, y: 108, width: 298, height: 32)
            self.currentSchoolEntry.frame = CGRect(x: 76, y: 138, width: 169, height: 30)
            
            
            
            
            self.doneButton.frame = CGRect(x: 80, y: 257, width: 161, height: 54)
        }
        
        
    }
    
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return pressed on second screen")
        
        dataController.savePhoneNumber(phoneNumber: phoneEntry.text!)
        dataController.saveSchool(schoolName: currentSchoolEntry.text!)
        
        textField.resignFirstResponder()
        return false
    }
    
    
    @IBAction func returnHome(_ sender: UIButton){
        dataController.savePhoneNumber(phoneNumber: phoneEntry.text!)
        dataController.saveSchool(schoolName: currentSchoolEntry.text!)
        
        infoController.save(screen: "main")
       
        dismiss(animated: true, completion: nil)
    }
    
}
