//
//  ExampleViewController.swift
//  HFCardCollectionViewLayoutExample
//
//  Created by Hendrik Frahmann on 28.10.16.
//  Copyright © 2016 Hendrik Frahmann. All rights reserved.
//

import UIKit
import HFCardCollectionViewLayout
import CoreData
import EasyTipView


struct CardInfo {
    var color: UIColor
    var icon: UIImage
}

extension EasyTipView{
    func shouldShow(newText: String) -> Bool{
        return text != newText
    }
}
struct CardLayoutSetupOptions {
    var firstMovableIndex: Int = 0
    var cardHeadHeight: CGFloat = 80
    var cardShouldExpandHeadHeight: Bool = true
    var cardShouldStretchAtScrollTop: Bool = true
    var cardMaximumHeight: CGFloat = 0
    var bottomNumberOfStackedCards: Int = 5
    var bottomStackedCardsShouldScale: Bool = true
    var bottomCardLookoutMargin: CGFloat = 10
    var bottomStackedCardsMaximumScale: CGFloat = 1.0
    var bottomStackedCardsMinimumScale: CGFloat = 0.94
    var spaceAtTopForBackgroundView: CGFloat = 0
    var spaceAtTopShouldSnap: Bool = true
    var spaceAtBottom: CGFloat = 0
    var scrollAreaTop: CGFloat = 120
    var scrollAreaBottom: CGFloat = 120
    var scrollShouldSnapCardHead: Bool = false
    var scrollStopCardsAtTop: Bool = true
    
    var numberOfCards: Int = 15
}
class cardViewController : UICollectionViewController, HFCardCollectionViewLayoutDelegate, EasyTipViewDelegate {
    func easyTipViewDidDismiss(_ tipView: EasyTipView) {
        // do nothing
    }
    
    
    var cardCollectionViewLayout: HFCardCollectionViewLayout?
    
    var infoController = userInfo()
    var dataController = newDataManager()
    
    @IBOutlet weak var objectiveEntry: UITextView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var backgroundNavigationBar: UINavigationBar?
    
    @IBOutlet weak var goEditButton: UIButton!
    
    
    @IBOutlet weak var saveObjectiveButton: UIButton!
    
    @IBOutlet weak var topView: UIView!
    
    
    
    
    var cardLayoutOptions: CardLayoutSetupOptions?
    var shouldSetupBackgroundView = true
    
    var cardArray: [CardInfo] = []
    var user: [NSManagedObject] = []
    private var tipView:EasyTipView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var layoutOptions = CardLayoutSetupOptions()
        layoutOptions.numberOfCards                  = 4
        layoutOptions.firstMovableIndex              = 0
        layoutOptions.cardHeadHeight                 = 80
        layoutOptions.cardShouldExpandHeadHeight     = true //self.switchCardShouldExpandHeadHeight!.isOn
        layoutOptions.cardShouldStretchAtScrollTop   = true //self.switchCardShouldStretchAtScrollTop!.isOn
        layoutOptions.cardMaximumHeight              = 0
        layoutOptions.bottomNumberOfStackedCards     = 5
        layoutOptions.bottomStackedCardsShouldScale  = true //self.switchBottomStackedCardsShouldScale!.isOn
        layoutOptions.bottomCardLookoutMargin        = 10
        layoutOptions.spaceAtTopForBackgroundView    = 121 //50*2 + 10
        layoutOptions.spaceAtTopShouldSnap           = true //self.switchSpaceAtTopShouldSnap!.isOn
        layoutOptions.spaceAtBottom                  = 10
        layoutOptions.scrollAreaTop                  = 120
        layoutOptions.scrollAreaBottom               = 120
        layoutOptions.scrollShouldSnapCardHead       = true //self.switchScrollShouldSnapCardHead!.isOn
        layoutOptions.scrollStopCardsAtTop           = true //self.switchScrollStopCardsAtTop!.isOn
        layoutOptions.bottomStackedCardsMinimumScale = 0.94
        layoutOptions.bottomStackedCardsMaximumScale = 1.0
        
        self.cardLayoutOptions = layoutOptions
        
        
        backgroundNavigationBar?.isHidden = false
        backgroundNavigationBar?.isUserInteractionEnabled = true
        
        
        self.objectiveEntry.layer.cornerRadius = 15
        self.objectiveEntry.clipsToBounds = true
        self.setupExample()
        
        setUpData()
        let aUser = user.last
        let objectiveText = aUser?.value(forKeyPath: "objective") as? String
        if(objectiveText != nil){
            objectiveEntry.text = objectiveText
        }
        
        
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(self.userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
        
    }
    
    @objc func userDefaultsDidChange(){
        determineTutorial()
    }
    
    
    

    
    var preferences: EasyTipView.Preferences!
    var tipArr = [EasyTipView]()
    func determineTutorial(){
        infoController.refresh()
        if(infoController.isTutorailComplete()){
            if(tipView != nil){
                tipView.dismiss()
            }
            return
        }
        preferences = EasyTipView.Preferences()
        preferences.drawing.font = UIFont(name: "Futura-Medium", size: 20)!
        preferences.drawing.foregroundColor = UIColor.white
        preferences.drawing.backgroundColor = UIColor(hue:0.46, saturation:0.99, brightness:0.6, alpha:1)
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.top
        
        
        /*
         * Optionally you can make these preferences global for all future EasyTipViews
         */
        
        EasyTipView.globalPreferences = preferences
        
        
        if(infoController.getProgress() == 1){
            print("Arya is here")
            let newTipView = EasyTipView(text: "Tap \"Add Item\" to add a skill to your resume", preferences: preferences)
            tipView = newTipView
            tipView.show(forView: self.goEditButton, withinSuperview: self.view)
            tipArr.append(newTipView)
        } else if(infoController.getProgress() == 6){
            let textToShow = "Add an objective here"
            if(!tipView.shouldShow(newText: textToShow)){
                return
            }
            let newTipView = EasyTipView(text: textToShow, preferences: preferences)
            tipView = newTipView
            tipView.show(forView: self.objectiveEntry, withinSuperview: self.view)
            tipArr.append(newTipView)
            let timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(saveObjectiveTutorial), userInfo: nil, repeats: false)
        }  else if(infoController.getProgress() == 7){
            
            let newTipView = EasyTipView(text: "Tap \"Add Item\" to add a course to your resume", preferences: preferences)
            tipView = newTipView
            tipView.show(forView: self.goEditButton, withinSuperview: self.view)
            tipArr.append(newTipView)
        } else if(infoController.getProgress() == 10){
            preferences.drawing.backgroundColor = UIColor.red
            let newTipView = EasyTipView(text: "Swipe left to view your resume", preferences: preferences)
            tipView = newTipView
            tipView.show(forView: self.backgroundView, withinSuperview: self.view)
            tipArr.append(newTipView)
            let timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissTimer), userInfo: nil, repeats: false)
        }else if(infoController.getProgress() == 12){
            infoController.disableTutorial()
        }
        
    
    
    }
    
    func determineDismissal(){
        for aTip in tipArr{
            aTip.dismiss()
        }
        
        if(tipView == nil){
            return
        }
        if(!infoController.isTutorailComplete() && infoController.getProgress() == 1){
            infoController.incrementTutorialProgress()
            //tipView.dismiss()
        } else if( !infoController.isTutorailComplete() && infoController.getProgress() == 7){
            infoController.incrementTutorialProgress()
            //tipView.dismiss()
        }else if(infoController.getProgress() == 6){
            infoController.incrementTutorialProgress()
            //tipView.dismiss()
            
            
        }else if(infoController.getProgress() == 12){
            infoController.disableTutorial()
        }
    }
    
    
    
    
    @objc func dismissTimer(){
        for aTip in tipArr{
            aTip.dismiss()
        }
        //tipView.dismiss()
        infoController.incrementTutorialProgress()
        //tipView.dismiss()
    }
   
    @objc func saveObjectiveTutorial(){
        for aTip in tipArr{
            aTip.dismiss()
        }
        let newTipView = EasyTipView(text: "Tap \"Save Objective\" when done", preferences: preferences)
        tipView = newTipView
        tipView.show(forView: self.saveObjectiveButton, withinSuperview: self.view)
        tipArr.append(newTipView)
        
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("View appears")
        //determineTutorial()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    
    
    
    
   
    var reloadCounter = 0
    /// Saves the objective entered at the top and displays a message notifying the user
    /// that the save has been executed correctly.
    ///
    /// - Parameter sender: the sender passed from the save objective button.
    @IBAction func saveObjective(_ sender: Any) {
        determineDismissal()
        dataController.saveObjective(objective: objectiveEntry.text)
        //infoController.saveChangeText(text: String(reloadCounter))
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
        
        
        determineTutorial()
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func goToEditViewController(_ sender: Any) {
        
        print("Going to edit")
        determineDismissal()

        self.performSegue(withIdentifier: "goEdit", sender: nil)
    }
    
   
    
    
    func cardCollectionViewLayout(_ collectionViewLayout: HFCardCollectionViewLayout, willRevealCardAtIndex index: Int) {
        if let cell = self.collectionView?.cellForItem(at: IndexPath(item: index, section: 0)) as? CollectionViewCell {
            cell.cardCollectionViewLayout = self.cardCollectionViewLayout
            cell.cardIsRevealed(true)
        }
    }
    
   
    func cardCollectionViewLayout(_ collectionViewLayout: HFCardCollectionViewLayout, willUnrevealCardAtIndex index: Int) {
        if let cell = self.collectionView?.cellForItem(at: IndexPath(item: index, section: 0)) as? CollectionViewCell {
            cell.cardCollectionViewLayout = self.cardCollectionViewLayout
            cell.cardIsRevealed(false)
            
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cardArray.count
    }
    var cardCounter = 0
    let sections = ["Experience", "Skills", "Courses","Extracurriculars"]
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /**
        if(cardCounter < 1){
            determineTutorial()
        }
        */
        if(cardCounter  == 4) {
            cardCounter = 0
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CollectionViewCell
        if(cell.CellIndexNumber == -1){
            
            cell.backgroundColor = self.cardArray[indexPath.item].color
            cell.imageIcon?.image = self.cardArray[indexPath.item].icon
            print("the card counter is" + String(cardCounter) + "    " +  sections[cardCounter])
            cell.labelText?.text = sections[cardCounter]
            
            cell.resumeSection = sections[cardCounter]
            cell.labelText?.font = UIFont(name: "HKGrotesk-RegularLegacy", size: 28)
            
            
        }
        
    
       
        
       
        if(cardCounter == 0 && cell.CellIndexNumber == -1){
            cell.backgroundColor = UIColor(red:0.23, green:0.42, blue:0.86, alpha:1.0)
            
        }else if(cardCounter == 1 && cell.CellIndexNumber == -1){
            cell.backgroundColor = UIColor(red:0.82, green:0.65, blue:0.06, alpha:1.0)
            
            
        }else if(cardCounter == 2 && cell.CellIndexNumber == -1){
            cell.backgroundColor = UIColor(red:0.71, green:0.38, blue:0.50, alpha:1.0)
            
            
        }
        //Change this color later so it matches the other 3
        else if(cardCounter == 3 && cell.CellIndexNumber == -1){
            cell.backgroundColor = UIColor(red:0.15, green:0.62, blue:0.11, alpha:1.0)
        }
        
        cell.CellIndexNumber = cardCounter
        cell.cellCounter = cardCounter
        
        cardCounter += 1
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cardCollectionViewLayout?.revealCardAt(index: indexPath.item)
        print("Card selected")
        determineTutorial()
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempItem = self.cardArray[sourceIndexPath.item]
        self.cardArray.remove(at: sourceIndexPath.item)
        self.cardArray.insert(tempItem, at: destinationIndexPath.item)
    }
 
    // MARK: Actions
    
    @IBAction func goBackAction() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    /// Upon pressing of the add Item button, this function triggers the screen to transition
    /// to the edit viewcontroller where users add items to their resumes
    ///
    /// - Parameter sender: the sender passsed from the add item button.
    @IBAction func addItem(_ sender: Any) {
        
        
        
        performSegue(withIdentifier: "goEdit", sender: self)
    }
    
    /**
    @IBAction func addCardAction() {
        let index = 0
        let newItem = createCardInfo()
        self.cardArray.insert(newItem, at: index)
        self.collectionView?.insertItems(at: [IndexPath(item: index, section: 0)])
        
        if(self.cardArray.count == 1) {
            self.cardCollectionViewLayout?.revealCardAt(index: index)
        }
    }
     */
    
    /// If delete button is pressed on a cell, delete the cell as well as its contents
    ///
    ///
    @IBAction func deleteCardAtIndex0orSelected() {
        var index = 0
        if(self.cardCollectionViewLayout!.revealedIndex >= 0) {
            index = self.cardCollectionViewLayout!.revealedIndex
        }
        self.cardCollectionViewLayout?.flipRevealedCardBack(completion: {
            self.cardArray.remove(at: index)
            self.collectionView?.deleteItems(at: [IndexPath(item: index, section: 0)])
        })
    }
    
    
    ///Sets up the defaults for a card
    ///
    
    private func setupExample() {
        if let cardCollectionViewLayout = self.collectionView?.collectionViewLayout as? HFCardCollectionViewLayout {
            self.cardCollectionViewLayout = cardCollectionViewLayout
        }
        if(self.shouldSetupBackgroundView == true) {
            self.setupBackgroundView()
        }
        if let cardLayoutOptions = self.cardLayoutOptions {
            self.cardCollectionViewLayout?.firstMovableIndex = cardLayoutOptions.firstMovableIndex
            self.cardCollectionViewLayout?.cardHeadHeight = cardLayoutOptions.cardHeadHeight
            self.cardCollectionViewLayout?.cardShouldExpandHeadHeight = cardLayoutOptions.cardShouldExpandHeadHeight
            self.cardCollectionViewLayout?.cardShouldStretchAtScrollTop = cardLayoutOptions.cardShouldStretchAtScrollTop
            self.cardCollectionViewLayout?.cardMaximumHeight = cardLayoutOptions.cardMaximumHeight
            self.cardCollectionViewLayout?.bottomNumberOfStackedCards = cardLayoutOptions.bottomNumberOfStackedCards
            self.cardCollectionViewLayout?.bottomStackedCardsShouldScale = cardLayoutOptions.bottomStackedCardsShouldScale
            self.cardCollectionViewLayout?.bottomCardLookoutMargin = cardLayoutOptions.bottomCardLookoutMargin
            self.cardCollectionViewLayout?.spaceAtTopForBackgroundView = cardLayoutOptions.spaceAtTopForBackgroundView
            self.cardCollectionViewLayout?.spaceAtTopShouldSnap = cardLayoutOptions.spaceAtTopShouldSnap
            self.cardCollectionViewLayout?.spaceAtBottom = cardLayoutOptions.spaceAtBottom
            self.cardCollectionViewLayout?.scrollAreaTop = cardLayoutOptions.scrollAreaTop
            self.cardCollectionViewLayout?.scrollAreaBottom = cardLayoutOptions.scrollAreaBottom
            self.cardCollectionViewLayout?.scrollShouldSnapCardHead = cardLayoutOptions.scrollShouldSnapCardHead
            self.cardCollectionViewLayout?.scrollStopCardsAtTop = cardLayoutOptions.scrollStopCardsAtTop
            self.cardCollectionViewLayout?.bottomStackedCardsMinimumScale = cardLayoutOptions.bottomStackedCardsMinimumScale
            self.cardCollectionViewLayout?.bottomStackedCardsMaximumScale = cardLayoutOptions.bottomStackedCardsMaximumScale
            
            let count = cardLayoutOptions.numberOfCards
            
            for index in 0..<count {
                self.cardArray.insert(createCardInfo(), at: index)
            }
        }
        self.collectionView?.reloadData()
    }
    
    private func createCardInfo() -> CardInfo {
        let icons: [UIImage] = [UIImage(), UIImage(), UIImage(),UIImage(),UIImage(),UIImage()]
        let icon = icons[Int(arc4random_uniform(6))]
        let newItem = CardInfo(color: self.getRandomColor(), icon: icon)
        return newItem
    }
    
    private func setupBackgroundView() {
        if(self.cardLayoutOptions?.spaceAtTopForBackgroundView == 0) {
            self.cardLayoutOptions?.spaceAtTopForBackgroundView = 80 // Height of the NavigationBar in the BackgroundView
        }
        if let collectionView = self.collectionView {
            collectionView.backgroundView = self.backgroundView
            self.backgroundNavigationBar?.shadowImage = UIImage()
            self.backgroundNavigationBar?.setBackgroundImage(UIImage(), for: .default)
            
            self.backgroundNavigationBar?.clipsToBounds = true
        }
    }
    
    private func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    
    ///Sets up the data from the 
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
}

