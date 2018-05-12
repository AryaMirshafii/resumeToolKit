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
    private var dataController = newDataManager()
    private var infoController = userInfo()
    
    
    
    @IBOutlet weak var pleaseEnterNameLabel: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.lastNameEntry.delegate = self
        self.lastNameEntry.clearButtonMode = .whileEditing
        self.lastNameEntry.becomeFirstResponder()
        
       
    }
    
    
    
    
    
    
    
    ///  When enter/return is pressed in keyboard, entered data is saved and segue is preformed to the next sceen
    ///
    /// - Parameter textField:
    /// - Returns: true when enter is pressed
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
