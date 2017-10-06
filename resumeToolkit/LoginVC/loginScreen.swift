//
//  loginScreen.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/1/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit
class loginScreen: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameEntry: UITextField!
    @IBOutlet weak var lastNameEntry: UITextField!
    @IBOutlet weak var emailEntry: UITextField!
    @IBOutlet weak var doneButton: UIButton!

    
    

    
    
    var dataController = dataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.firstNameEntry.delegate = self
        self.firstNameEntry.clearButtonMode = .whileEditing
        /**
        firstNameEntry.layer.cornerRadius = firstNameEntry.frame.height/2
        firstNameEntry.layer.borderWidth = 2
        firstNameEntry.layer.borderColor = UIColor(red:0.00, green:0.40, blue:0.80, alpha:1.0).cgColor
        firstNameEntry.clipsToBounds = true
        */
        
        
        self.lastNameEntry.delegate = self
        self.lastNameEntry.clearButtonMode = .whileEditing
        /**
        self.lastNameEntry.layer.cornerRadius = self.lastNameEntry.frame.height/2
        lastNameEntry.layer.borderWidth = 2
       lastNameEntry.layer.borderColor = UIColor(red:0.00, green:0.40, blue:0.80, alpha:1.0).cgColor
        lastNameEntry.clipsToBounds = true
         */
        
        
        
        self.emailEntry.delegate = self
        self.emailEntry.clearButtonMode = .whileEditing
        /**
        self.emailEntry.layer.cornerRadius = self.emailEntry.frame.height/2
        emailEntry.layer.borderWidth = 2
        emailEntry.layer.borderColor = UIColor(red:0.00, green:0.40, blue:0.80, alpha:1.0).cgColor
        emailEntry.clipsToBounds = true
         */
        
        
        
        //doneButton.layer.backgroundColor = UIColor(red:0.00, green:0.40, blue:0.80, alpha:1.0).cgColor
        self.doneButton.layer.cornerRadius = self.doneButton.frame.height/2
        doneButton.clipsToBounds = true
        
        
        
        
        //firstNameEntry.addTarget(self, action: "textFieldDidChange:", for: UIControlEvents.editingChanged)
        //firstNameEntry.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
       // self.firstNameEntry.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    @objc func textFieldDidChange() {
        //dataController.savefirstName(firstName: firstNameEntry.text!)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return pressed")
        dataController.savefirstName(firstName: firstNameEntry.text!)
        dataController.saveLastName(lastName: lastNameEntry.text!)
        dataController.saveEmail(email: emailEntry.text!)
        
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func goToNextScreen(_ sender: UIButton){
        dataController.savefirstName(firstName: firstNameEntry.text!)
        dataController.saveLastName(lastName: lastNameEntry.text!)
        dataController.saveEmail(email: emailEntry.text!)
        performSegue(withIdentifier: "go", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "go" {
            
            
            print("going")
            
            
            
            
        }
        
        
    }
    
    
    
    
    

}
