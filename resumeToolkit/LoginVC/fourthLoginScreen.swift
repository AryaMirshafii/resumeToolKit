//
//  fourthLoginScreen.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 10/25/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit


class fourthLoginScreen: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var phoneEntry: UITextField!
    private var dataController = newDataManager()
    private var infoController = userInfo()
  
    
    
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
        self.phoneEntry.becomeFirstResponder()
        self.phoneEntry.keyboardType = .numbersAndPunctuation
        
        
    
        
    }
    
    
   
    
    
    ///  When enter/return is pressed in keyboard, entered data is saved and segue is preformed to the next sceen
    ///
    /// - Parameter textField:
    /// - Returns: true when enter is pressed
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
