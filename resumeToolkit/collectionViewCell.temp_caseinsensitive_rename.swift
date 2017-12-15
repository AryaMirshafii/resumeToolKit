//
//  ExampleCollectionViewCell.swift
//  HFCardCollectionViewLayoutExample
//
//  Created by Hendrik Frahmann on 02.11.16.
//  Copyright © 2016 Hendrik Frahmann. All rights reserved.
//

import UIKit
import QuartzCore
import HFCardCollectionViewLayout
import CoreData

class CollectionViewCell: HFCardCollectionViewCell {
    
    var cardCollectionViewLayout: HFCardCollectionViewLayout?
    
    @IBOutlet var buttonFlip: UIButton?
    @IBOutlet var tableView: UITableView?
    @IBOutlet var labelText: UILabel?
    @IBOutlet var imageIcon: UIImageView?
    
    @IBOutlet var backView: UIView?
    @IBOutlet var buttonFlipBack: UIButton?
    var itemsDict = [String:[resumeItem]]()
    var dataController = dataManager()
    var user: [NSManagedObject] = []
    let sections = ["Internship & Job Experience", "Skills", "Courses","Extracurriculars"]
    var experrienceList = [resumeItem]()
    var skillsList = [resumeItem]()
    var courseList = [resumeItem]()
    var ExtracurricularsList = [resumeItem]()
    var resumeSection  = " " 
    override func awakeFromNib() {
        super.awakeFromNib()
        self.buttonFlip?.isHidden = true
        self.tableView?.scrollsToTop = false
        
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.allowsSelectionDuringEditing = false
        self.tableView?.rowHeight = 150
        self.tableView?.reloadData()
        generateItemsDict()
    }
    
    func cardIsRevealed(_ isRevealed: Bool) {
        self.buttonFlip?.isHidden = !isRevealed
        self.tableView?.scrollsToTop = isRevealed
    }
    
    @IBAction func buttonFlipAction() {
        if let backView = self.backView {
            // Same Corner radius like the contentview of the HFCardCollectionViewCell
            backView.layer.cornerRadius = self.cornerRadius
            backView.layer.masksToBounds = true
            
            self.cardCollectionViewLayout?.flipRevealedCard(toView: backView)
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
            let userExtracurriculars = aUser?.value(forKeyPath: "extracurriculars") as? String
            
            print("going here")
            
            var experienceArr = userExpereience?.components(separatedBy:"-")
            var skillsArr = userSkills?.components(separatedBy:"-")
            var coursesArr = userCourses?.components(separatedBy:"-")
            var ExtracurricularsArr = userExtracurriculars?.components(separatedBy:"-")
            
            
            
            if(aSection == "Internship & Job Experience" && userExpereience != nil){
                experrienceList.removeAll()
                
                if(experienceArr != nil){
                    for anExperience in experienceArr!{
                        if(!anExperience.isEmpty && anExperience != "entryInfo[1]_entryInfo[2]"){
                            experrienceList.append(createResumeItem(description: anExperience))
                        }
                        
                    }
                    itemsDict[aSection]  = experrienceList
                    
                } else {
                    itemsDict[aSection] = [createResumeItem(description: userExpereience!)]
                }
                
                counter += 1
                
                
                
            }
            
            if(aSection == "Skills" && userSkills != nil){
                
                if(skillsArr != nil){
                    skillsList.removeAll()
                    for aSkill in skillsArr!{
                        let aResumeItem = createResumeItem(description: aSkill)
                        if(aResumeItem.name != "entryInfo[1]" ){
                            skillsList.append(aResumeItem)
                        }
                        
                    }
                    itemsDict[aSection]  = skillsList
                    
                } else {
                    itemsDict[aSection] = [createResumeItem(description: userSkills!)]
                }
                
                counter += 1
                
                
                
            }
            
            if(aSection == "Courses" && userCourses != nil){
                
                if(coursesArr != nil){
                    courseList.removeAll()
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
                
            }
            
            if(aSection == "Extracurriculars" && userExtracurriculars != nil){
                
                if(ExtracurricularsArr != nil){
                    ExtracurricularsList.removeAll()
                    for anAward in ExtracurricularsArr!{
                        if(!anAward.isEmpty){
                            ExtracurricularsList.append(createResumeItem(description: anAward))
                        }
                        
                    }
                    itemsDict[aSection]  = ExtracurricularsList
                    
                } else {
                    itemsDict[aSection] = [createResumeItem(description: userExtracurriculars!)]
                }
                
                counter += 1
                
                
                
            }
            
        }
        
    }
    
    
    func setUpData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        var managedContext:NSManagedObjectContext
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        
        let userRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        do {
            user = try managedContext.fetch(userRequest)
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    func createResumeItem(description: String) -> resumeItem{
        let entryInfo = description.components(separatedBy: "_")
        
        if(entryInfo[0] == "Skill"){
            
            return skill(name: entryInfo[1], description: entryInfo[2],entryType: entryInfo[0])
        } else if(entryInfo[0] == "Professional Development"){
            
            //return experience(name: entryInfo[1], description: entryInfo[2])
            return experience(name: entryInfo[1], dateStarted: entryInfo[2], dateEnded: entryInfo[3], companyName: entryInfo[4], companyContact: entryInfo[5], description: entryInfo[6], entryType:entryInfo[0] )
        } else if(entryInfo[0] == "Courses"){
            
            return course(name: entryInfo[1], description: entryInfo[2],entryType:entryInfo[0])
        } else if(entryInfo[0] == "Extracurriculars"){
            return Award(name: entryInfo[1], description: entryInfo[2],entryType:entryInfo[0])
        }
        return resumeItem(name: "entryInfo[1]", description: "entryInfo[2]", entryType:"None")
    }
   var cellCounter = 0
    var CellIndexNumber:Int = -1
    
}

extension CollectionViewCell : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(itemsDict[resumeSection] !=  nil){
            return (itemsDict[resumeSection]?.count)!
        }
        return 1
        
    }
    //creates individual cells in the card change this for each type of skill
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(itemsDict)
        let cell = tableView.dequeueReusableCell(withIdentifier: "resumeItemCell") as! resumeItemCell
        let aSection = self.sections[self.cellCounter]
        print("meanwhile the cell c0ounter is" + String(cellCounter))
        if(!itemsDict.isEmpty) {
            
            print(aSection + "     " + String(self.cellCounter))
            
            //cell.itemNameLabel?.text = "Table Cell #\(indexPath.row)"
            //cell.itemNameLabel?.textColor = .white
            
            //let aSection = self.sections[cellCounter]
            var items = self.itemsDict[aSection]
            //print(aSection + "    "  + String(describing: items))
            if(items != nil){
                cell.itemNameLabel.isHidden = false
                cell.entryDescriptionField.isHidden = false
                cell.itemNameLabel.text = items![indexPath.row].name
                cell.itemNameLabel?.textColor = .white
                cell.entryDescriptionField.text = items![indexPath.row].description
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                //return cell
            } else {
                cell.itemNameLabel.isHidden = true
                cell.entryDescriptionField.isHidden = true
            }
            //cellCounter += 1
           
            //return cell
        }
        //cellCounter += 1
       return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // nothing
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let anAction = UITableViewRowAction(style: .default, title: "An Action")
        {
            (action, indexPath) -> Void in
            // code for action
        }
        return [anAction]
    }
    
}
