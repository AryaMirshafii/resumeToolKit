//
//  firstLoginScreen.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 10/25/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import Device_swift

class firstLoginScreen:UIViewController,UITextFieldDelegate {
    @IBOutlet weak var firstNameEntry: UITextField!
    var dataController = dataManager()
    var infoController = userInfo()
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var pleaseEnterNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.firstNameEntry.delegate = self
        self.firstNameEntry.clearButtonMode = .whileEditing
        
        let deviceType = UIDevice.current.deviceType
        
        switch deviceType {
        case .iPhone5:
            print("iphone 5")
        case .iPadAir2:
            self.backgroundImage.frame = CGRect(x: 0, y: 0, width: 768, height: 1024)
            self.pleaseEnterNameLabel.frame = CGRect(x: 235, y: 569, width: 298, height: 32)
            self.firstNameEntry.frame = CGRect(x: 272, y: 654, width: 224, height: 30)
            self.icon.frame = CGRect(x: 217, y: 180, width: 334, height: 317)
            
            
        default: print("Check other available cases of DeviceType")
        }
    

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dataController.savefirstName(firstName: firstNameEntry.text!)
        
        
        textField.resignFirstResponder()
        //dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "1to2", sender: self)
        
        
        
        return true
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "1to2" {
            print("1to2")
  
        }
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
