//
//  resumeDataController.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/7/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class resumeDataController: UITableViewController, UISearchBarDelegate, UIPopoverPresentationControllerDelegate {
    
    
    
    
    
    
    var resumeItems =  [resumeItem]()
    
    var itemsDict = [String:[resumeItem]]()
    let sections = ["Experience", "Skills", "Schoolwork"]
    
    var user: [NSManagedObject] = []
    var infoController = userInfo()
    
    
    
    override func viewDidLoad() {
        
        
        
        
        
        setUpData()
        
        
        let anExperience = resumeItem(name: "java",description: " I became proficient in java after taking cs1331")
        let aSkill = resumeItem(name: "Microsoft Office" , description: " I can create word documents as well as powerpoints and spreadsheets")
        let schoolWork = resumeItem(name: "ECE2026" , description: "Introduction to signal processing")
        
        
        
        
        resumeItems.append(anExperience)
        resumeItems.append(aSkill)
        resumeItems.append(schoolWork)
        
        
        
        generateItemsDict()
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(self.userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    @objc func userDefaultsDidChange() {
        self.tableView.reloadData()
    }
    
    func setUpData(){
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
    var counter = 0
    func generateItemsDict(){
        let aUser = user.last
        for aSection in sections {
            let userExpereience = aUser?.value(forKeyPath: "experience") as? String
            let userSkills = aUser?.value(forKeyPath: "skills") as? String
            let userSchoolWork = aUser?.value(forKeyPath: "schoolWork") as? String
            
            
            if(aSection == "Experience" && userExpereience != nil){
                itemsDict[aSection] = [createResumeItem(description: userExpereience!)]
                counter += 1
            }
            
            if(aSection == "Skills" && userSkills != nil){
                itemsDict[aSection] = [createResumeItem(description: userSkills!)]
                counter += 1
            }
            
            if(aSection == "Schoolwork" && userSchoolWork != nil){
                itemsDict[aSection] = [createResumeItem(description: userSchoolWork!)]
                counter += 1
                print("creating)
            }
            
        }
    }
    
    func createResumeItem(description: String) -> resumeItem{
        let entryInfo = description.components(separatedBy: "_")
        
        if(entryInfo[0] == "Skill"){
            
            return skill(name: entryInfo[1], description: entryInfo[2])
        } else if(entryInfo[0] == "Experience"){
            return experience(name: entryInfo[1], description: entryInfo[2])
        } else if(entryInfo[0] == "Schoolwork"){
            return schoolWork(name: entryInfo[1], description: entryInfo[2])
        }
        return resumeItem(name: entryInfo[1], description: entryInfo[2])
    }
    
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.sections[section]
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let wordKey = sections[section]
        if(itemsDict[wordKey] == nil){
            return 0
        }
        return itemsDict[wordKey]!.count
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table view data source
    
    
    
    
    
    
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
    
    
    
    @IBAction func addItem(_ sender: UIButton){
        performSegue(withIdentifier: "goEdit", sender: self)
    }
    
    
   
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "entryCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? entryCell  else {
            fatalError("The dequeued cell is not an instance of entryCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let aSection = sections[indexPath.section]
        let items = itemsDict[aSection]
        //print(anItem.name)
        cell.entryName.text = items![indexPath.row].name
        cell.entryDescription.text = items![indexPath.row].description
        self.tableView.rowHeight = 226
        
       return cell
    }
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

 
