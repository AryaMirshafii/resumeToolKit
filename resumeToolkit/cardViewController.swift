//
//  ExampleViewController.swift
//  HFCardCollectionViewLayoutExample
//
//  Created by Hendrik Frahmann on 28.10.16.
//  Copyright © 2016 Hendrik Frahmann. All rights reserved.
//

import UIKit
import HFCardCollectionViewLayout

struct CardInfo {
    var color: UIColor
    var icon: UIImage
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
class cardViewController : UICollectionViewController, HFCardCollectionViewLayoutDelegate {
    
    var cardCollectionViewLayout: HFCardCollectionViewLayout?
    
    
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var backgroundNavigationBar: UINavigationBar?
    
    var cardLayoutOptions: CardLayoutSetupOptions?
    var shouldSetupBackgroundView = true
    
    var cardArray: [CardInfo] = []
    
    override func viewDidLoad() {
        
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
        layoutOptions.spaceAtTopForBackgroundView    = 50
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
        
        
        
        self.setupExample()
        super.viewDidLoad()
    }
    
    // MARK: CollectionView
    
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
    let sections = ["Internship & Job Experience", "Skills", "Courses","Extracurriculars"]
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
            cell.labelText?.font = UIFont(name: "Prime-Regular", size: 28)
            
            
        }
       
        
       
        if(cardCounter == 0){
            cell.backgroundColor = UIColor(red:0.23, green:0.42, blue:0.86, alpha:1.0)
            
        }else if(cardCounter == 1 && cell.CellIndexNumber == -1){
            cell.backgroundColor = UIColor(red:0.71, green:0.38, blue:0.50, alpha:1.0)
            
        }else if(cardCounter == 2 && cell.CellIndexNumber == -1){
            cell.backgroundColor = UIColor(red:0.15, green:0.62, blue:0.11, alpha:1.0)
            
        }
        //Change this color later so it matches the other 3
        else if(cardCounter == 3 && cell.CellIndexNumber == -1){
            cell.backgroundColor = UIColor(red:0.46, green:0.62, blue:0.11, alpha:1.0)
        }
        
        cell.CellIndexNumber = cardCounter
        cell.cellCounter = cardCounter
        
        cardCounter += 1
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cardCollectionViewLayout?.revealCardAt(index: indexPath.item)
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
    
    // MARK: Private Functions
    
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
}

