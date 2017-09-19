//
//  secondLoginScreen.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/6/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit
import GoogleAPIClientForREST
import GoogleSignIn

class secondLoginScreen: UIViewController, UITextFieldDelegate,GIDSignInDelegate, GIDSignInUIDelegate  {
    @IBOutlet weak var phoneEntry: UITextField!
    @IBOutlet weak var currentSchoolEntry: UITextField!
    @IBOutlet weak var gradeLevelEntry: UITextField!
    
    @IBOutlet weak var doneButton: UIButton!
    
    
    
    
    let service = GTLRDriveService()
    let signInButton = GIDSignInButton()
    let output = UITextView()
    private let scopes = ["https://www.googleapis.com/auth/drive.file"]
    
    var dataController = dataManager()
    var infoController = userInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        
        
        self.phoneEntry.delegate = self
        self.phoneEntry.clearButtonMode = .whileEditing
        self.phoneEntry.layer.cornerRadius = self.phoneEntry.frame.height/2
        phoneEntry.clipsToBounds = true
        
        
        
        self.currentSchoolEntry.delegate = self
        self.currentSchoolEntry.clearButtonMode = .whileEditing
        self.currentSchoolEntry.layer.cornerRadius = self.currentSchoolEntry.frame.height/2
        currentSchoolEntry.clipsToBounds = true
        
        
        
        
        
        
        
        
        
        
        
        
        self.gradeLevelEntry.delegate = self
        self.gradeLevelEntry.clearButtonMode = .whileEditing
        self.gradeLevelEntry.layer.cornerRadius = self.gradeLevelEntry.frame.height/2
        gradeLevelEntry.clipsToBounds = true
        
        
        
        
        
        
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
       
        GIDSignIn.sharedInstance().clientID = "699945398009-sms6e0cpoam9cp6631nbi38v910s73rv.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().signInSilently()
        signInButton.frame = CGRect(x: (view.frame.width - signInButton.frame.width)/2, y:  320, width: signInButton.frame.width, height: signInButton.frame.height)
        doneButton.frame = CGRect(x: (view.frame.width - doneButton.frame.width)/2, y:  390, width: doneButton.frame.width, height: doneButton.frame.height)
        // Add the sign-in button.
        view.addSubview(signInButton)
        
        
       
        
        //UNCOMMENT
        //let setUpUser = userSetUp(driveService: service)
        //setUpUser?.initSetup()
        
        
        
        
    }
    
    
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            //showAlert(title: "Authentication Error", message: error.localizedDescription)
            self.service.authorizer = nil
        } else {
            self.signInButton.isHidden = true
            //doneButton.frame = CGRect(x:  134, y:  362, width: doneButton.frame.width, height: doneButton.frame.height)
            self.output.isHidden = false
            self.service.authorizer = user.authentication.fetcherAuthorizer()
            
            
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return pressed on second screen")
        
        dataController.savePhoneNumber(phoneNumber: phoneEntry.text!)
        dataController.saveSchool(schoolName: currentSchoolEntry.text!)
        dataController.saveGradeLevel(gradeLevel: gradeLevelEntry.text!)
        textField.resignFirstResponder()
        return false
    }
    
    
    @IBAction func returnHome(_ sender: UIButton){
        dataController.savePhoneNumber(phoneNumber: phoneEntry.text!)
        dataController.saveSchool(schoolName: currentSchoolEntry.text!)
        dataController.saveGradeLevel(gradeLevel: gradeLevelEntry.text!)
        infoController.save(screen: "main")
        dismiss(animated: true, completion: nil)
    }
    
}
