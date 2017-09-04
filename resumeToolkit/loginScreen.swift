//
//  loginScreen.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/1/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit
class loginScreen: UIViewController {
    
    @IBOutlet weak var firstNameEntry: UITextField!
    @IBOutlet weak var lastNameEntry: UITextField!
    
    var dataController = dataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameEntry.clearButtonMode = .whileEditing
        firstNameEntry.layer.cornerRadius = firstNameEntry.frame.height/2
        
        //firstNameEntry.addTarget(self, action: "textFieldDidChange:", for: UIControlEvents.editingChanged)
        //firstNameEntry.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.firstNameEntry.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    @objc func textFieldDidChange() {
        dataController.savefirstName(firstName: firstNameEntry.text!)
        
    }
    
    
    
    

}
