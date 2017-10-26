//
//  secondLogin.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 10/25/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation

class secondLogin: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var lastNameEntry: UITextField!
    var dataController = dataManager()
    var infoController = userInfo()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.lastNameEntry.delegate = self
        self.lastNameEntry.clearButtonMode = .whileEditing
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dataController.saveLastName(lastName: lastNameEntry.text!)
        
        
        textField.resignFirstResponder()
        //dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "2to3", sender: self)
        
        
       
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "2to3" {
            print("2to3")
            
        }
    }
}
