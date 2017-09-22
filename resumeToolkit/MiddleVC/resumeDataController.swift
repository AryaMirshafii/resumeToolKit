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
    
    
    
    
    
    
    
    
    var itemsDict = [String:[resumeItem]]()
    let sections = ["Professional Development", "Skills", "Courses","Awards"]
    
    var user: [NSManagedObject] = []
    var infoController = userInfo()
    var experrienceList = [resumeItem]()
    var skillsList = [resumeItem]()
    var courseList = [resumeItem]()
    var awardsList = [resumeItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        //self.setUpData()
        
        
        
        
        
        generateItemsDict()
        
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(self.userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
        self.tableView.backgroundColor = .black
        self.view.backgroundColor = .black
    }
    
    @objc func userDefaultsDidChange() {
        generateItemsDict()
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
       
        setUpData()
        let aUser = user.last
        for aSection in sections {
            let userExpereience = aUser?.value(forKeyPath: "experience") as? String
            let userSkills = aUser?.value(forKeyPath: "skills") as? String
            let userCourses = aUser?.value(forKeyPath: "courses") as? String
            let userAwards = aUser?.value(forKeyPath: "awards") as? String
           
            print("going here")
            
            var experienceArr = userExpereience?.components(separatedBy:"-")
            var skillsArr = userSkills?.components(separatedBy:"-")
            var coursesArr = userCourses?.components(separatedBy:"-")
            var awardsArr = userAwards?.components(separatedBy:"-")
            
            
           
            if(aSection == "Professional Development" && userExpereience != nil){
               
                
                if(experienceArr != nil){
                    for anExperience in experienceArr!{
                        if(!anExperience.isEmpty){
                            experrienceList.append(createResumeItem(description: anExperience))
                        }
                        
                    }
                    itemsDict[aSection]  = experrienceList
                    
                } else {
                    itemsDict[aSection] = [createResumeItem(description: userExpereience!)]
                }
                
                counter += 1
                
                experrienceList.removeAll()
                    //[createResumeItem(description: String(describing: userExpereience))]
            }
            
            if(aSection == "Skills" && userSkills != nil){
               // itemsDict[aSection] = [createResumeItem(description: userSkills!)]
                //counter += 1
                
                
                
                
                
                if(skillsArr != nil){
                    for aSkill in skillsArr!{
                        skillsList.append(createResumeItem(description: aSkill))
                    }
                    itemsDict[aSection]  = skillsList
                    
                } else {
                    itemsDict[aSection] = [createResumeItem(description: userSkills!)]
                }
                
                counter += 1
                
                skillsList.removeAll()
                
                
                
            }
            
            if(aSection == "Courses" && userCourses != nil){
                //itemsDict[aSection] = [createResumeItem(description: usercourses!)]
                //counter += 1
                
                
                if(coursesArr != nil){
                    for aCourse in coursesArr!{
                        if(!aCourse.isEmpty){
                            courseList.append(createResumeItem(description: aCourse))
                        }
                        
                    }
                    itemsDict[aSection]  = courseList
                    
                } else {
                    itemsDict[aSection] = [createResumeItem(description: userCourses!)]
                }
                
                counter += 1
                
                courseList.removeAll()
                
            }
            
            if(aSection == "Awards" && userAwards != nil){
                //itemsDict[aSection] = [createResumeItem(description: usercourses!)]
                //counter += 1
                
                
                if(awardsArr != nil){
                    for anAward in awardsArr!{
                        if(!anAward.isEmpty){
                            awardsList.append(createResumeItem(description: anAward))
                        }
                        
                    }
                    itemsDict[aSection]  = awardsList
                    
                } else {
                    itemsDict[aSection] = [createResumeItem(description: userAwards!)]
                }
                
                counter += 1
                
                awardsList.removeAll()
                
            }
            
        }
    }
    
    func createResumeItem(description: String) -> resumeItem{
        let entryInfo = description.components(separatedBy: "_")
        
        if(entryInfo[0] == "Skill"){
            
            return skill(name: entryInfo[1], description: entryInfo[2])
        } else if(entryInfo[0] == "Professional Development"){
            
            return experience(name: entryInfo[1], description: entryInfo[2])
        } else if(entryInfo[0] == "Courses"){
            
            return course(name: entryInfo[1], description: entryInfo[2])
        } else if(entryInfo[0] == "Awards"){
            return Award(name: entryInfo[1], description: entryInfo[2])
        }
        return resumeItem(name: "entryInfo[1]", description: "entryInfo[2]")
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
        self.tableView.rowHeight = 180
        
       return cell
    }
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

 
