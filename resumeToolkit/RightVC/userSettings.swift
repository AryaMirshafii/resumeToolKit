//
//  userSettings.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/6/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class userSettings: UIViewController,UITextFieldDelegate{
    var user: [NSManagedObject] = []
    var dataController = dataManager()
    
    
    @IBOutlet weak var firstNameEntry: UITextField!
    @IBOutlet weak var lastNameEntry: UITextField!
    @IBOutlet weak var emailEntry: UITextField!
    @IBOutlet weak var phoneEntry: UITextField!
    @IBOutlet weak var currentSchoolEntry: UITextField!
    @IBOutlet weak var gradeLevelEntry: UITextField!
    
    
    var userInfoController = userInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.firstNameEntry.delegate = self
        self.lastNameEntry.delegate = self
        self.emailEntry.delegate = self
        self.phoneEntry.delegate = self
        self.currentSchoolEntry.delegate = self
        self.gradeLevelEntry.delegate = self
        
 
        
        
        loadData()
        userDefaultsDidChange()
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
        
        
        
        firstNameEntry.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        lastNameEntry.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emailEntry.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        phoneEntry.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        currentSchoolEntry.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        gradeLevelEntry.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
     @objc func userDefaultsDidChange() {
        loadData()
        print("USER DEFAULTS CHANGED")
        let aUser = user.last
        if(userInfoController.fetchData() == "main"){
            firstNameEntry.text = aUser?.value(forKeyPath: "firstName") as? String
            lastNameEntry.text = aUser?.value(forKeyPath: "lastName") as? String
            emailEntry.text = aUser?.value(forKeyPath: "emailAdress") as? String
            phoneEntry.text = aUser?.value(forKeyPath: "phoneNumber") as? String
            currentSchoolEntry.text = aUser?.value(forKeyPath: "schoolName") as? String
            gradeLevelEntry.text = aUser?.value(forKeyPath: "gradeLevel") as? String
            
            
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dataController.savefirstName(firstName: firstNameEntry.text!)
        dataController.saveLastName(lastName: lastNameEntry.text!)
        dataController.saveEmail(email: emailEntry.text!)
        dataController.savePhoneNumber(phoneNumber: phoneEntry.text!)
        dataController.saveSchool(schoolName: currentSchoolEntry.text!)
        dataController.saveGradeLevel(gradeLevel: gradeLevelEntry.text!)
        
        
        let aRandomNumber = String(arc4random_uniform(100) + 1)
        print("!!!" + aRandomNumber)
        userInfoController.saveChangeText(text: aRandomNumber)
        view.endEditing(true)
        
        
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        /**
        dataController.savefirstName(firstName: firstNameEntry.text!)
        dataController.saveLastName(lastName: lastNameEntry.text!)
        dataController.saveEmail(email: emailEntry.text!)
        dataController.savePhoneNumber(phoneNumber: phoneEntry.text!)
        dataController.saveSchool(schoolName: currentSchoolEntry.text!)
        dataController.saveGradeLevel(gradeLevel: gradeLevelEntry.text!)
        
        
        let aRandomNumber = String(arc4random_uniform(100) + 1)
        print("!!!" + aRandomNumber)
        userInfoController.saveChangeText(text: aRandomNumber)
 */
    }
    
    
    func loadData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        //let timeRequest = NSFetchRequest<NSManagedObject>(entityName: "Time")
        do {
            user = try managedContext.fetch(userRequest)
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
