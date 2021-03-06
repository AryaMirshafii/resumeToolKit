//
//  ContainerViewController.swift
//  SnapchatSwipeView
//
//  Created by Jake Spracher on 8/9/15.
//  Copyright (c) 2015 Jake Spracher. All rights reserved.
//

import UIKit

protocol SnapContainerViewControllerDelegate {
    func outerScrollViewShouldScroll() -> Bool
}

class SnapContainerViewController: UIViewController, UIScrollViewDelegate {
    
    var topVc: UIViewController?
    var leftVc: UIViewController!
    var middleVc: UIViewController!
    var rightVc: UIViewController!
    var bottomVc: UIViewController?
    var viewArray: [UIViewController]!
    
    var directionLockDisabled: Bool!
    
    var horizontalViews = [UIViewController]()
    var veritcalViews = [UIViewController]()
    
    var initialContentOffset = CGPoint() // scrollView initial offset
    
    var scrollView: UIScrollView!
    var delegate: SnapContainerViewControllerDelegate?
    var infoController = userInfo()
    
    class func containerViewWith(_ leftVC: UIViewController,
                                 //middleVC: UIViewController,
                                 rightVC: UIViewController,
                                 viewArray: [UIViewController],
                                 topVC: UIViewController?=nil,
                                 bottomVC: UIViewController?=nil,
                                 directionLockDisabled: Bool?=false) -> SnapContainerViewController {
        var container = SnapContainerViewController()
        
        container.directionLockDisabled = directionLockDisabled
        
        container.topVc = topVC
        container.leftVc = leftVC
        //container.middleVc = middleVC
        container.rightVc = rightVC
        container.bottomVc = bottomVC
        container.viewArray = viewArray
        return container
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if(infoController.fetchData() == "main2"){
            self.middleVc = viewArray[1]
            
        } else {
             self.middleVc = viewArray[0]
        }
        
       
        setupHorizontalScrollView()
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(self.userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    @objc func userDefaultsDidChange() {
        if(infoController.fetchData() == "main" && infoController.fetchChangeText() == "bbb"){
            self.middleVc = viewArray[1]
            setupHorizontalScrollView()
            infoController.save(screen: "main2")
            //NotificationCenter.default.removeObserver(self)
        }
    }
    
    
    
    
    func setupHorizontalScrollView() {
        scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        
        let view = (
            x: self.view.bounds.origin.x,
            y: self.view.bounds.origin.y,
            width: self.view.bounds.width,
            height: self.view.bounds.height
        )

        scrollView.frame = CGRect(x: view.x,
                                  y: view.y,
                                  width: view.width,
                                  height: view.height
        )
        
        self.view.addSubview(scrollView)
        
        let scrollWidth  = 3 * view.width
        let scrollHeight  = view.height
        scrollView.contentSize = CGSize(width: scrollWidth, height: scrollHeight)
        
        leftVc.view.frame = CGRect(x: 0,
                                   y: 0,
                                   width: view.width,
                                   height: view.height
        )
        
        middleVc.view.frame = CGRect(x: view.width,
                                               y: 0,
                                               width: view.width,
                                               height: view.height
        )
        
        rightVc.view.frame = CGRect(x: 2 * view.width,
                                    y: 0,
                                    width: view.width,
                                    height: view.height
        )
        
        addChildViewController(leftVc)
        addChildViewController(middleVc)
        addChildViewController(rightVc)
        
        scrollView.addSubview(leftVc.view)
        scrollView.addSubview(middleVc.view)
        scrollView.addSubview(rightVc.view)
        
        leftVc.didMove(toParentViewController: self)
        middleVc.didMove(toParentViewController: self)
        rightVc.didMove(toParentViewController: self)
        
        scrollView.contentOffset.x = middleVc.view.frame.origin.x
        scrollView.delegate = self
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.initialContentOffset = scrollView.contentOffset
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if delegate != nil && !delegate!.outerScrollViewShouldScroll() && !directionLockDisabled {
            let newOffset = CGPoint(x: self.initialContentOffset.x, y: self.initialContentOffset.y)
        
            // Setting the new offset to the scrollView makes it behave like a proper
            // directional lock, that allows you to scroll in only one direction at any given time
            self.scrollView!.setContentOffset(newOffset, animated:  false)
        }
    }
    
}
