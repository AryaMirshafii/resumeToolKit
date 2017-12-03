//
//  fifthLoginScreen.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 10/25/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit

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
