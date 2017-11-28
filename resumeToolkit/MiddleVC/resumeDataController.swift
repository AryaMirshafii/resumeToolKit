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
    
    
    
    
    @IBOutlet weak var saveObjectiveButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addView: UIView!
    
    @IBOutlet weak var objectiveField: UITextView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var topView: UIView!
    
    var itemsDict = [String:[resumeItem]]()
    var searchDict = [String:[resumeItem]]()
    let sections = ["Internship & Job Experience", "Skills", "Courses","Extracurriculars"]
    
    var user: [NSManagedObject] = []
    var infoController = userInfo()
    var experrienceList = [resumeItem]()
    var skillsList = [resumeItem]()
    var courseList = [resumeItem]()
    var ExtracurricularsList = [resumeItem]()
    var dataController = dataManager()
    
    var searchText = " "
    var isSearching = false
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.becomeFirstResponder()
        let backgroundImage = UIImageView(image: #imageLiteral(resourceName: "lightBlue"))
        self.tableView.backgroundView = backgroundImage
        self.tableView.separatorStyle = .none
        //self.tableView.backgroundColor = .white
        
        
        //self.setUpData()
        
        
        
        
        
        generateItemsDict()
        
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(self.userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
        
        setUpData()
        let aUser = user.last
        let objectiveText = aUser?.value(forKeyPath: "objective") as? String
        if(objectiveText != nil){
            objectiveField.text = objectiveText
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        
        
        self.objectiveField.layer.cornerRadius = 10
        objectiveField.clipsToBounds = true
        
        
        self.setUpSearchBar()
        
        let deviceType = UIDevice.current.deviceType
        if(deviceType == .iPadAir2){
            self.objectiveField.frame = CGRect(x: 8, y: 33, width: 750, height: 60)
        } else {
            self.objectiveField.frame = CGRect(x: 8, y: 33, width: 357, height: 60)
        }

        
    }
    
    
    func setUpSearchBar(){
        self.searchBar.barTintColor =  UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.0)
        self.searchBar.layer.borderColor = UIColor.clear.cgColor
        self.searchBar.placeholder = "Search by name or description"
        self.searchBar.delegate = self
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(isSearching){
            view.endEditing(true)
        }
       
    }
    
    
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("call me")
        if searchText.isEmpty {
            //self.addView.frame = CGRect(x: 0, y: 0, width: 357, height: 194)
            isSearching = false
            generateItemsDict()
            //self.tableView.reloadData()
            print("ARYA SEARCHING")
            self.topView.frame = CGRect(x: 0, y: 0, width: 375, height: 200)
            self.addView.frame = CGRect(x: 0, y: 53, width: 375, height: 147)
            
        }else {
            self.addView.frame = CGRect(x: 900, y: -900, width: 375, height: 194)
            self.topView.frame = CGRect(x: 0, y: 0, width: 375, height: 56)
            generateItemsDict()
            isSearching = true
            print("ARYA NOT SEARCHING")
            filterTableView(text: searchText)
            
        }
        
        if searchBar.text == nil || searchBar.text == ""
        {
            
            searchBar.perform(#selector(self.resignFirstResponder), with: nil, afterDelay: 0.1)
        }
        
        
    }
    
    func getTitles(){
        
    }
    
    
    func filterTableView(text: String) {
        
        
        
       
        
        print("searching for" + text)
        
        searchDict["Skills"] = skillsList.filter({ (mod) -> Bool in
            
           return mod.name.lowercased().contains(text.lowercased()) || mod.description.lowercased().contains(text.lowercased())
        })
        
        
        
        
        
        searchDict["Courses"] = courseList.filter({ (mod) -> Bool in
            
            return mod.name.lowercased().contains(text.lowercased()) || mod.description.lowercased().contains(text.lowercased())
        })
        
        
        searchDict["Internship & Job Experience"] = experrienceList.filter({ (mod) -> Bool in
            
            return mod.name.lowercased().contains(text.lowercased()) || mod.description.lowercased().contains(text.lowercased())
        })
        
        
        searchDict["Extracurriculars"] = ExtracurricularsList.filter({ (mod) -> Bool in
            
            return mod.name.lowercased().contains(text.lowercased()) || mod.description.lowercased().contains(text.lowercased())
        })
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func userDefaultsDidChange() {
        generateItemsDict()
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
    
    
    
    
    var reloadCounter = 0
    @IBAction func saveObjective(_ sender: Any) {
        dataController.saveObjective(statement: objectiveField.text)
        infoController.saveChangeText(text: String(reloadCounter))
        reloadCounter += 1
        view.endEditing(true)
        var alert = UIAlertController(title: "Saved!",
                                      message: "Your objective has been saved.",
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        
        
        
        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        
        subview.backgroundColor = UIColor(red:0.91, green:0.38, blue:0.50, alpha:1.0)
        alert.view.tintColor = .black
        
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.sections[section]
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let wordKey = sections[section]
        if(isSearching){
            return searchDict[wordKey]!.count
        }
        if(itemsDict[wordKey] == nil){
            return 0
        }
        return itemsDict[wordKey]!.count
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
    
    
    
    @IBAction func addItem(_ sender: UIButton){
        performSegue(withIdentifier: "goEdit", sender: self)
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    
    
   
    
    
    var colorCounter = 0
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "entryCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? entryCell  else {
            fatalError("The dequeued cell is not an instance of entryCell.")
        }
        
        if(self.isSearching){
            self.itemsDict = self.searchDict
            
        }
        
        let aSection = self.sections[indexPath.section]
        var items = self.itemsDict[aSection]
        
        
        
        
        
        
        cell.entryName.text = items![indexPath.row].name
        cell.entryDescription.text = items![indexPath.row].description
        self.tableView.rowHeight = 160
        cell.cellType = items![indexPath.row].entryType
        
        
        
        
        cell.contentView.backgroundColor = UIColor.clear
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 160))
        
        whiteRoundedView.layer.backgroundColor = UIColor(red:0.77, green:0.79, blue:0.83, alpha:1.0).cgColor
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        cell.getColor(aNumber: self.colorCounter)
        
        if(self.colorCounter < 3){
            self.colorCounter += 1
        }
        if (self.colorCounter == 3) {
            self.colorCounter += -3
        }
        
        
        
        
        
        
        
        
        
       return cell
    }
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.isUserInteractionEnabled = true
        headerView.backgroundColor = UIColor.clear
        
        let headerLabel = UITextField(frame: CGRect(x: 6, y: 10, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Prime", size: 28)
        
        headerLabel.textColor = .white
       
        
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
       
        headerLabel.sizeToFit()
        headerLabel.adjustsFontSizeToFitWidth = true
        let deviceType = UIDevice.current.deviceType
        
        switch deviceType {
        case .iPhone5:
            headerLabel.font = UIFont(name: "Prime", size: 27)
            self.addButton.frame = CGRect(x: 92, y: 7, width: 136, height: 44)
            self.addView.frame = CGRect(x: 0, y: 0, width: 320, height: 50)
        case .iPadAir2:
            self.addView.frame = CGRect(x: 0, y: 53, width: 768, height: 147)
            self.addButton.frame = CGRect(x: 8, y: 95, width: 136, height: 44)
            self.saveObjectiveButton.frame = CGRect(x: 593, y: 95, width: 165, height: 44)
            
        default: print("Check other available cases of DeviceType")
        }
        
        
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

 
