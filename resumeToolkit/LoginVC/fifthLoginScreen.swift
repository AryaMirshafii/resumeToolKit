//
//  fifthLoginScreen.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 10/25/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit
import Device_swift
class fifthLoginScreen: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var currentSchoolEntry: UITextField!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var pleaseEnterSchoolLabel: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    
    var dataController = dataManager()
    var infoController = userInfo()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.currentSchoolEntry.delegate = self
        self.currentSchoolEntry.clearButtonMode = .whileEditing
        currentSchoolEntry.text = "Georgia Tech Excel Program"
        
        
       
        
        let deviceType = UIDevice.current.deviceType
        
        switch deviceType {
        case .iPhone5:
            print("iphone 5")
        case .iPadAir2:
            self.backgroundImage.frame = CGRect(x: 0, y: 0, width: 768, height: 1024)
            self.pleaseEnterSchoolLabel.frame = CGRect(x: 235, y: 569, width: 298, height: 32)
            self.currentSchoolEntry.frame = CGRect(x: 272, y: 654, width: 224, height: 30)
            self.icon.frame = CGRect(x: 217, y: 180, width: 334, height: 317)
            
            
        default: print("Check other available cases of DeviceType")
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dataController.saveSchool(schoolName: currentSchoolEntry.text!)
        infoController.save(screen: "main")
        textField.resignFirstResponder()
        performSegue(withIdentifier: "unwindto1", sender: self)
        
        
       
        
        
        return true
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "5to1" {
            
            
            
        }
    }
    
    
    
    
    
    
}
