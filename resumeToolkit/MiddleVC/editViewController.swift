//
//  editViewController.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/7/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit


class editViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    let dataController = dataManager()
    
    @IBOutlet weak var entryPicker: UIPickerView!
    @IBOutlet weak var entryName: UITextField!
    @IBOutlet weak var entryDescription: UITextView!
    @IBOutlet weak var classList: UIView!
    
    var pickerData: [String] = [String]()
    var theCategory: String!
    
    var infoController = userInfo()
    let skillPicker = UIPickerView()
    
    var reloadCounter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        entryDescription.text  = " "
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        
        pickerData.append("Skill")
        pickerData.append("Experience")
        pickerData.append("Schoolwork")
        self.entryPicker.delegate = self
        self.entryPicker.dataSource = self
        self.entryPicker.layer.cornerRadius = 20
        
        
        
        
        theCategory = pickerData[0]
        if(theCategory == "Skill"){
            classList.isHidden = true
            entryName.frame = CGRect(x: 100, y: 11, width: entryName.frame.width, height: entryName.frame.height)
        }
    }
    @IBAction func goBack(_ sender: UIButton){
        
        print("!!!" + theCategory!)
        if(theCategory == "Skill"){
            classList.isHidden = true
            
            dataController.saveSkills(skills: "Skill" + "_" + entryName.text! + "_" + entryDescription.text)
        } else if(theCategory == "Experience"){
            
            dataController.saveExperience(experience: "Experience" + "_" + entryName.text! + "_" + entryDescription.text)
        } else if(theCategory == "Schoolwork"){
            dataController.saveSchoolWork(schoolWork: "SchoolWork" + "_" + entryName.text! + "_" + entryDescription.text)
        }
        infoController.saveChangeText(text: String(reloadCounter))
        reloadCounter += 1
        dismiss(animated: true, completion: nil)
    }
    
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        theCategory = pickerData[row]
        if(theCategory == "Skill"){
            classList.isHidden = true
            entryName.frame = CGRect(x: 100, y: 11, width: entryName.frame.width, height: entryName.frame.height)
        } else {
            classList.isHidden = false
            
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        
        
        
        view.endEditing(true)
        
        
    }
}
