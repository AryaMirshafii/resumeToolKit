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
import Device_swift


class resumeDataController: UITableViewController, UISearchBarDelegate, UIPopoverPresentationControllerDelegate {
    
    
    
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addView: UIView!
    
    
    
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
        let backgroundImage = UIImageView(image: #imageLiteral(resourceName: "lightBlue"))
        self.tableView.backgroundView = backgroundImage
        self.tableView.separatorStyle = .none
        //self.tableView.backgroundColor = .white
        
        
        //self.setUpData()
        
        
        
        
        
        generateItemsDict()
        
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(self.userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
        
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
                        if(!anExperience.isEmpty && anExperience != "entryInfo[1]_entryInfo[2]"){
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
            
            //return experience(name: entryInfo[1], description: entryInfo[2])
            return experience(name: entryInfo[1], dateStarted: entryInfo[2], dateEnded: entryInfo[3], companyName: entryInfo[4], companyContact: entryInfo[5], description: entryInfo[6])
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
    
    
   
    
    
    var colorCounter = 0
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
        self.tableView.rowHeight = 160
        
        
        
        
        cell.contentView.backgroundColor = UIColor.clear
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 160))
        
        whiteRoundedView.layer.backgroundColor = UIColor(red:0.77, green:0.79, blue:0.83, alpha:1.0).cgColor
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        cell.getColor(aNumber: colorCounter)
        
        if(colorCounter < 3){
            colorCounter += 1
        }
        if (colorCounter == 3) {
            colorCounter += -3
        }
        
        
       return cell
    }
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        
        let headerLabel = UILabel(frame: CGRect(x: 6, y: 10, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Prime", size: 30)
        //headerLabel.textColor = UIColor(red:0.00, green:0.40, blue:0.80, alpha:1.0)
        headerLabel.textColor = .white
       
        
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        //headerLabel.textAlignment = NSTextAlignment.center
        headerLabel.sizeToFit()
        //headerLabel.adjustsFontSizeToFitWidth = true
        let deviceType = UIDevice.current.deviceType
        
        switch deviceType {
        case .iPhone5:
            headerLabel.font = UIFont(name: "Prime", size: 27)
            self.addButton.frame = CGRect(x: 92, y: 7, width: 136, height: 44)
            self.addView.frame = CGRect(x: 0, y: 0, width: 320, height: 50)
        case .iPadMini: print("Do stuff for iPad mini")
        default: print("Check other available cases of DeviceType")
        }
        
        
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

 
