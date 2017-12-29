//
//  firstLoginScreen.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 10/25/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation


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
        self.icon.isHidden = true
        self.firstNameEntry.becomeFirstResponder()
        
        
    

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
