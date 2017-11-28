//
//  fourthLoginScreen.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 10/25/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit
import Device_swift
class fourthLoginScreen: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var phoneEntry: UITextField!
    var dataController = dataManager()
    var infoController = userInfo()
    
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var pleaseEnterPhone: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.phoneEntry.delegate = self
        self.phoneEntry.clearButtonMode = .whileEditing
        
        
        
        let deviceType = UIDevice.current.deviceType
        
        
        
        switch deviceType {
        case .iPhone5:
            print("iphone 5")
        case .iPadAir2:
            self.backgroundImage.frame = CGRect(x: 0, y: 0, width: 768, height: 1024)
            self.pleaseEnterPhone.frame = CGRect(x: 235, y: 569, width: 298, height: 32)
            self.phoneEntry.frame = CGRect(x: 272, y: 654, width: 224, height: 30)
            self.icon.frame = CGRect(x: 217, y: 180, width: 334, height: 317)
            
            
        default: print("Check other available cases of DeviceType")
        }
        
        
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dataController.savePhoneNumber(phoneNumber: phoneEntry.text!)
        
        textField.resignFirstResponder()
        //dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "4to5", sender: self)
       
        
        
        
        
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "4to5" {
            print("4to5")
            
            
        }
    }
    
    
    
}
