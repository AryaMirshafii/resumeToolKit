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
import EECellSwipeGestureRecognizer
import EasyTipView


class CollectionViewCell: HFCardCollectionViewCell,UITableViewDelegate, UITableViewDataSource,EasyTipViewDelegate {
    func easyTipViewDidDismiss(_ tipView: EasyTipView) {
      
        
    }
    
    
    var cardCollectionViewLayout: HFCardCollectionViewLayout?
    
    @IBOutlet   var buttonFlip: UIButton?
    @IBOutlet  var tableView: UITableView?
    @IBOutlet  var labelText: UILabel?
    @IBOutlet  var imageIcon: UIImageView?
    
    @IBOutlet  var backView: UIView?
    @IBOutlet  var buttonFlipBack: UIButton?
    
    
    
    var itemsDict = [String:[NSManagedObject]]()
    var dataController = newDataManager()
    private var infoController = userInfo()
    private var tipView:EasyTipView!
    
    let sections = ["Experience", "Skills", "Courses","Extracurriculars"]
    
    var resumeSection  = " "
    override func awakeFromNib() {
        super.awakeFromNib()
        self.buttonFlip?.isHidden = true
        self.tableView?.scrollsToTop = false
        
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.allowsSelectionDuringEditing = false
        self.tableView?.rowHeight = 160
        self.tableView?.reloadData()
        generateItemsDict()
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(self.userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
        determineTutorial()
    }
    
    
    var dropWarningCounter = 0
    
    func determineTutorial(){
        infoController.refresh()
        if(infoController.isTutorailComplete()){
            return
        }
        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = UIFont(name: "Futura-Medium", size: 20)!
        preferences.drawing.foregroundColor = UIColor.white
        preferences.drawing.backgroundColor = UIColor(hue:0.46, saturation:0.99, brightness:0.6, alpha:1)
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.top
        
        /*
         * Optionally you can make these preferences global for all future EasyTipViews
         */
        
        EasyTipView.globalPreferences = preferences
        
        
        if(self.resumeSection == "Skills" && infoController.getProgress() == 4){
            print("Showing swipe warning")
            
            tipView = EasyTipView(text: "Tap tap here to see your skill card", preferences: preferences)
            tipView.show(forView: self.labelText!, withinSuperview: self)
        } else if(self.resumeSection == "Skills" && infoController.getProgress() == 5){
            print("Showing remove warning")
            if(dropWarningCounter < 1){
                tipView = EasyTipView(text: "Tap or swipe down to dismiss", preferences: preferences)
                tipView.show(forView: self.labelText!, withinSuperview: self)
            }
            dropWarningCounter += 1
        }
    }
    
    
    
    // Detects if the user has added data and changes it accordingly
    // Usually trigered when reload counter is altered on other files.
    @objc private func userDefaultsDidChange() {
        print("user changginnnzz")
        generateItemsDict()
        
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    // Allows the card being revealed property to be set to true
    // This was used mostly in the developer's demo app but is always set to true in this app.
    func cardIsRevealed(_ isRevealed: Bool) {
        //determineTutorial()
        print("Isreavled is" + String(isRevealed))
        if(isRevealed && infoController.getProgress() == 4){
            infoController.incrementTutorialProgress()
            tipView.dismiss()
            determineTutorial()
            
        } else if (!isRevealed && infoController.getProgress() == 5){
            print("Isreavled is" + String(isRevealed))
            infoController.incrementTutorialProgress()
            tipView.dismiss()
            determineTutorial()
            
        }
        
        self.buttonFlip?.isHidden = !isRevealed
        self.tableView?.scrollsToTop = isRevealed
    }
    
    // Once again, this just allows the card to be flipped but this is never used
    @IBAction func buttonFlipAction() {
        print("going back")
        if let backView = self.backView {
            // Same Corner radius like the contentview of the HFCardCollectionViewCell
            backView.layer.cornerRadius = self.cornerRadius
            backView.layer.masksToBounds = true
            
            self.cardCollectionViewLayout?.flipRevealedCard(toView: backView)
        }
    }
    
    
    
    // Gets data from coredata model and generates a dictionary which is later used to load
    // data into the cards
    var counter = 0
    func generateItemsDict(){
        print("Generating Resume Items Dictionary")
        
        
        
        for aSection in sections {
            
            if(aSection == "Experience") {
                itemsDict[aSection] = dataController.fetchExperiences()
            } else if(aSection == "Skills") {
                itemsDict[aSection] = dataController.fetchSkills()
            } else if(aSection == "Courses") {
                itemsDict[aSection] = dataController.fetchCourses()
            } else if (aSection == "Extracurriculars"){
                itemsDict[aSection] = dataController.fetchExtraCurriculars()
            }
            
            
        }
            
        
    }
    
    
    
    
    
    
    
   
    
    var cellCounter = 0
    var CellIndexNumber:Int = -1
    
}
// UITableViewDelegate, UITableViewDataSource
extension CollectionViewCell  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(itemsDict[resumeSection] !=  nil){
            return (itemsDict[resumeSection]?.count)!
        }
        return 1
        
    }
    // creates individual cells in the card change this for each type of skill
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var items = self.itemsDict[self.resumeSection]
        if(!itemsDict.isEmpty) {
            if(self.resumeSection == "Experience"){
                let cell = tableView.dequeueReusableCell(withIdentifier: "experienceCell") as! experienceCell
                if(items != nil){
                    
                    self.tableView?.rowHeight = 230
                    let theExperienceItem = items![indexPath.row] as! experience
                    cell.positionlabel.text = theExperienceItem.name
                    cell.startYearLabel.text = theExperienceItem.yearStarted
                    cell.endYearLabel.text = theExperienceItem.yearEnded
                    cell.companyLabel.text = theExperienceItem.companyName
                    cell.experienceDescription.text = theExperienceItem.companyDescription
                    cell.theExperience = theExperienceItem
                    
                    
                    
                    let gestureRecognizer: EECellSwipeGestureRecognizer = EECellSwipeGestureRecognizer()
                    let action: EECellSwipeAction = EECellSwipeAction(fraction: 0.25)
                    
                    action.behavior = .push
                    action.icon = (UIImage(named: "cancel-button.png")?.withRenderingMode(.alwaysTemplate))!
                    
                    action.activeBackgroundColor = cell.contentView.backgroundColor!
                    //action.inactiveColor = .clear
                    action.inactiveBackgroundColor = cell.contentView.backgroundColor!
                    action.iconMargin = 40
                    
                    print("I am so triggered rn")
                    action.didChangeState = { (tableView, indexPath) in
                        
                        cell.activateTaps()
                        
                    }
                    gestureRecognizer.add(actions: [action])
                    cell.addGestureRecognizer(gestureRecognizer)
                    
                    return cell
                }
                
                
            } else if(self.resumeSection == "Skills") {
                let cell = tableView.dequeueReusableCell(withIdentifier: "skillCell") as! skillCell
                if(items != nil){
                    determineTutorial()
                    self.tableView?.rowHeight = 140
                    let theSkillItem = items![indexPath.row] as! skill
                    cell.skillNameLabel.text = theSkillItem.name
                    cell.skillDescription.text = theSkillItem.skillDescription
                    
                    
                    let gestureRecognizer: EECellSwipeGestureRecognizer = EECellSwipeGestureRecognizer()
                    let action: EECellSwipeAction = EECellSwipeAction(fraction: 0.25)
    
                    action.behavior = .push
                    action.icon = (UIImage(named: "cancel-button.png")?.withRenderingMode(.alwaysTemplate))!
                    
                    action.activeBackgroundColor = cell.contentView.backgroundColor!
                    //action.inactiveColor = .clear
                    action.inactiveBackgroundColor = cell.contentView.backgroundColor!
                    action.iconMargin = 40
                    
                    
                    action.didChangeState = { (tableView, indexPath) in
                        
                        cell.activateTaps()
            
                    }
                    gestureRecognizer.add(actions: [action])
                    cell.addGestureRecognizer(gestureRecognizer)
                    
                    
                    return cell
                }
                
            } else if(self.resumeSection == "Courses"){
                let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell") as! courseCell
                if(items != nil){
                    
                    self.tableView?.rowHeight = 150
                    let theCourseItem = items![indexPath.row] as! course
                    cell.courseNameLabel.text = theCourseItem.name
                    cell.courseDescription.text = theCourseItem.courseDescription
                    
                    
                    let gestureRecognizer: EECellSwipeGestureRecognizer = EECellSwipeGestureRecognizer()
                    let action: EECellSwipeAction = EECellSwipeAction(fraction: 0.25)
                    
                    action.behavior = .push
                    action.icon = (UIImage(named: "cancel-button.png")?.withRenderingMode(.alwaysTemplate))!
                    
                    action.activeBackgroundColor = cell.contentView.backgroundColor!
                    //action.inactiveColor = .clear
                    action.inactiveBackgroundColor = cell.contentView.backgroundColor!
                    action.iconMargin = 40
                    
                    print("I am so triggered rn")
                    action.didChangeState = { (tableView, indexPath) in
                        
                        cell.activateTaps()
                        
                    }
                    gestureRecognizer.add(actions: [action])
                    cell.addGestureRecognizer(gestureRecognizer)
                    
                    return cell
                }
                
            } else if(self.resumeSection == "Extracurriculars"){
                let cell = tableView.dequeueReusableCell(withIdentifier: "extracurricularCell") as! extracurricularCell
                if(items != nil){
                    
                    let theExtraCurricularItem = items![indexPath.row] as! extracurricular
                    cell.extracurricularNameLabel.text = theExtraCurricularItem.name
                    cell.extracurricularDescription.text = theExtraCurricularItem.ecDescription
                    cell.extracurricularYearLabel.text = theExtraCurricularItem.year
                    
                    
                    
                    let gestureRecognizer: EECellSwipeGestureRecognizer = EECellSwipeGestureRecognizer()
                    let action: EECellSwipeAction = EECellSwipeAction(fraction: 0.25)
                    
                    action.behavior = .push
                    action.icon = (UIImage(named: "cancel-button.png")?.withRenderingMode(.alwaysTemplate))!
                    
                    action.activeBackgroundColor = cell.contentView.backgroundColor!
                    //action.inactiveColor = .clear
                    action.inactiveBackgroundColor = cell.contentView.backgroundColor!
                    action.iconMargin = 40
                    
                    print("I am so triggered rn")
                    action.didChangeState = { (tableView, indexPath) in
                        
                        cell.activateTaps()
                        
                    }
                    gestureRecognizer.add(actions: [action])
                    cell.addGestureRecognizer(gestureRecognizer)
                    
                    
                    return cell
                }
                
            }
            
        }
        let cell = UITableViewCell()
        cell.isHidden = true
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            print("Removing an Item")
            self.itemsDict[resumeSection]?.remove(at: indexPath.row)
            
            
            self.tableView?.reloadData()
        }
    }
    
    

    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
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
