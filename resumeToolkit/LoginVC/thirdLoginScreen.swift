//
//  thirdLoginScreen.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 10/25/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit




class thirdLoginScreen: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var emailEntry: UITextField!
    private var dataController = newDataManager()
    private var infoController = userInfo()
    
    
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var pleaseEnterEmailLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.emailEntry.delegate = self
        self.emailEntry.clearButtonMode = .whileEditing
        self.emailEntry.becomeFirstResponder()
        emailEntry.keyboardType = .emailAddress
        
        
    }
    
    
    
    ///  When enter/return is pressed in keyboard, entered data is saved and segue is preformed to the next sceen
    ///
    /// - Parameter textField:
    /// - Returns: true when enter is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dataController.saveEmail(emailAddress: emailEntry.text!)
        
        
        textField.resignFirstResponder()
        //dismiss(animated: true, completion: nil)
        
        performSegue(withIdentifier: "3to4", sender: self)
        
        
        
        return true
    }
    
    
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "3to4" {
            print("3to4")
            
        }
    }
}
