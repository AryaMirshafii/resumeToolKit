//
//  pdfView.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/7/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import ASHorizontalScrollView
import MessageUI
import EasyTipView

class pdfView: UIViewController,UIScrollViewDelegate,MFMailComposeViewControllerDelegate,UIWebViewDelegate,EasyTipViewDelegate {
    func easyTipViewDidDismiss(_ tipView: EasyTipView) {
        
    }
    
    private var pdfGenerate = testPDFGenerator()
    private var infoController = userInfo()
    private var dataController = newDataManager()
    private var previousFilePath = " "
    
    
    //getfilepath ==
    
    @IBOutlet weak private var largeWebView: UIWebView!
    
    
    
    @IBOutlet weak private var webView: UIWebView!
    @IBOutlet weak private var resumeNameLabel: UILabel!
    @IBOutlet weak private var backgroundImage: UIImageView!
    private var tipView:EasyTipView!
    
    @IBOutlet weak private var userSelect: ASHorizontalScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.webView.delegate = self
        self.largeWebView.delegate = self
        
        
        userDefaultsDidChange()
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
       
        
        
        self.webView.isOpaque = true
        self.webView.backgroundColor = UIColor.clear
        self.largeWebView.isOpaque = true
        self.largeWebView.backgroundColor = UIColor.clear
        
        let button1 = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 140))
        let button2 = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 140))
        let button3 = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 140))
        let button4 = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 140))
        
        userSelect.uniformItemSize = CGSize(width: 90, height: 140)
        
        userSelect.marginSettings_375 =  MarginSettings(leftMargin: 20, miniMarginBetweenItems: 15, miniAppearWidthOfLastItem: 15)
        userSelect.marginSettings_768 =  MarginSettings(leftMargin: 40, miniMarginBetweenItems: 30, miniAppearWidthOfLastItem: 20)
        userSelect.marginSettings_414 =  MarginSettings(leftMargin: 30, miniMarginBetweenItems: 15, miniAppearWidthOfLastItem: 20)
        
        userSelect.clipsToBounds = true
        
        //button1.image = #imageLiteral(resourceName: "resume1Icon")
        //button2.image = #imageLiteral(resourceName: "resume2Icon")
        //button3.image = #imageLiteral(resourceName: "resume3Icon")
       // button4.image = #imageLiteral(resourceName: "resume4Icon")
        button1.setImage(#imageLiteral(resourceName: "resume1Icon"), for: .normal)
        button2.setImage(#imageLiteral(resourceName: "resume2Icon"), for: .normal)
        button3.setImage(#imageLiteral(resourceName: "resume3Icon"), for: .normal)
        button4.setImage(#imageLiteral(resourceName: "resume4Icon"), for: .normal)
        
        button1.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        button2.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
        button3.addTarget(self, action: #selector(button3Tapped), for: .touchUpInside)
        button4.addTarget(self, action: #selector(button4Tapped), for: .touchUpInside)
        
        
        
        userSelect.addItems([button1,button2,button3,button4])
       
        
        
        var contentRect = CGRect.zero
        for view in self.webView.scrollView.subviews {
            contentRect = contentRect.union(view.frame) }
        self.webView.scrollView.contentSize = contentRect.size
        
        
        
        
        
        for view in self.largeWebView.scrollView.subviews {
            contentRect = contentRect.union(view.frame) }
        self.largeWebView.scrollView.contentSize = contentRect.size
        
        self.userSelect.delegate = self
        self.userSelect.bounces = true
        
        
    
        
        if(infoController.getResumeIndex() == "0"){
            resumeNameLabel.text = "Plain"
            userSelect.contentOffset.x = 0 * (userSelect.frame.size.width/3.8)
            
            
        } else if(infoController.getResumeIndex() == "1"){
            resumeNameLabel.text = "Industrial"
            userSelect.contentOffset.x = 1 * (userSelect.frame.size.width/3.8)
            
        } else if(infoController.getResumeIndex() == "2") {
            resumeNameLabel.text = "Modern Minimalist"
            userSelect.contentOffset.x = 2 * (userSelect.frame.size.width/3.8)
        }
        else if(infoController.getResumeIndex() == "3") {
            resumeNameLabel.text = "Vibrant Modern"
            userSelect.contentOffset.x = 3 * (userSelect.frame.size.width/3.8)
        }
        
        determineTutorial()
        
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("Looking at pdf view")
        
    }
    
    
    var preferences: EasyTipView.Preferences!
    var tipArr = [EasyTipView]()
    func determineTutorial(){
        infoController.refresh()
        if(infoController.isTutorailComplete()){
            return
        }
        preferences = EasyTipView.Preferences()
        preferences.drawing.font = UIFont(name: "Futura-Medium", size: 20)!
        preferences.drawing.foregroundColor = UIColor.white
        preferences.drawing.backgroundColor = UIColor(hue:0.46, saturation:0.99, brightness:0.6, alpha:1)
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.bottom
        preferences.drawing.arrowHeight = 30
        preferences.drawing.arrowWidth = 30
        
        /*
         * Optionally you can make these preferences global for all future EasyTipViews
         */
        
        EasyTipView.globalPreferences = preferences
        
        
        if(infoController.getProgress() == 11){
            if(tipView == nil || tipView.shouldShow(newText: "Congrats!!! You are now done with the tutorial! Tap me to dismiss")) {
                print("Showing first tutorial")
                let newTipView  = EasyTipView(text: "Select a resume style by moving or tapping the icons below", preferences: preferences)
                tipView = newTipView
                tipView.show(forView: self.userSelect, withinSuperview: self.view)
                tipArr.append(newTipView)
                infoController.disableTutorial()
            }
            
            
        }
        
        
        
    }
    
    func determineDismissal(){
        
        for atip in tipArr{
           
            atip.dismiss()
            
        }
        
        let newTipView  = EasyTipView(text: "Congrats!!! You are now done with the tutorial! Tap me to dismiss", preferences: preferences)
        tipView = newTipView
        tipView.show(forView: self.userSelect, withinSuperview: self.view)
        tipArr.append(newTipView)
        //infoController.disableTutorial()
        
    }
    
    
    
    
    
    
    func button1Tapped(){
        determineDismissal()
        resumeNameLabel.text = "Plain"
        infoController.saveResumeIndex(resumeIndexAt: "0")
        userSelect.contentOffset.x = 0 * (userSelect.frame.size.width/3.8)
    }
    func button2Tapped(){
        determineDismissal()
        resumeNameLabel.text = "Industrial"
        infoController.saveResumeIndex(resumeIndexAt: "1")
        userSelect.contentOffset.x = 1 * (userSelect.frame.size.width/3.8)
    }
    
    func button3Tapped(){
        determineDismissal()
        resumeNameLabel.text = "Modern Minimalist"
        infoController.saveResumeIndex(resumeIndexAt: "2")
        userSelect.contentOffset.x = 2 * (userSelect.frame.size.width/3.8)
    }
    func button4Tapped(){
        determineDismissal()
        resumeNameLabel.text = "Vibrant Modern"
        infoController.saveResumeIndex(resumeIndexAt: "3")
        userSelect.contentOffset.x = 3 * (userSelect.frame.size.width/3.8)
    }
    
    
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        determineDismissal()
        perform(#selector(self.actionOnFinishedScrolling), with: nil, afterDelay: Double(velocity.x))
    }
    
    
    
    /// Determines which resume style is selected from horizontal scroll view
    @objc private func actionOnFinishedScrolling() {
        print("scrolling is finished")
        let resumeToPick = String(Int(abs(round(userSelect.contentOffset.x / (userSelect.frame.size.width/3.8)))))
        print("THE INDEX IS" + resumeToPick + infoController.getResumeIndex())
        infoController.saveResumeIndex(resumeIndexAt: resumeToPick)
        if(resumeToPick == "0"){
            resumeNameLabel.text = "Plain"
            
            
        } else if(resumeToPick == "1"){
            resumeNameLabel.text = "Industrial"
            
        } else if(resumeToPick == "2") {
            resumeNameLabel.text = "Modern Minimalist"
        }
        else if(resumeToPick == "3") {
            resumeNameLabel.text = "Vibrant Modern"
        }
        
        
       
    }
    
    
    
    
    
    
    // Re-renders resume if user defaults changed
    // This is usually called when the user has added something new to resume and it needs to be updated
    //
    //
    private var counter = 0
    @objc private func userDefaultsDidChange() {
        print("I AM WORKING")
        
        
        
        let pdfResult = pdfGenerate.createPDFFileAndReturnPath(indexAt: infoController.getResumeIndex())
        if(infoController.fetchData() == "main" && infoController.fetchChangeText() == "bbb" ){
            print("in1")
            
            //let pdfResult = pdfGenerate.createPDFFileAndReturnPath(indexAt: userInfoController.getResumeIndex())
            loadPDF(html: pdfResult.html, filePath: String(describing: pdfResult.output))
        }else if(infoController.fetchChangeText() != "bbb"){
            //let pdfResult = pdfGenerate.createPDFFileAndReturnPath(indexAt: userInfoController.getResumeIndex())
            loadPDF(html: pdfResult.html, filePath: String(describing: pdfResult.output))
            
        }
        
        
        let pdfData = NSMutableData()
        
        self.largeWebView.stringByEvaluatingJavaScript(from: "document.body.style.zoom = 0.8;")
        self.largeWebView.contentMode = .scaleAspectFit
       

        
        loadPDF(html: pdfResult.html, filePath: String(describing: pdfResult.output))
        
        UIGraphicsBeginPDFContextToData(pdfData, largeWebView.bounds, nil)
        defer { UIGraphicsEndPDFContext() }
        UIGraphicsBeginPDFPage()
        
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return }
        
        let rescale: CGFloat = 5
        
        func scaler(v: UIView) {
            if !v.isKind(of:UIStackView.self) {
                v.contentScaleFactor = 8
            }
            for sv in v.subviews {
                scaler(v: sv)
            }
        }
        scaler(v: self.largeWebView)
        
        let bigSize = CGSize(width: largeWebView.frame.size.width*rescale, height: largeWebView.frame.size.height*rescale)
        UIGraphicsBeginImageContextWithOptions(bigSize, true, 1)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(UIColor.white.cgColor)
        context.fill(CGRect(origin: CGPoint(x: 0, y: 0), size: bigSize))
        
        
        context.scaleBy(x: rescale, y: rescale)
        largeWebView.layer.render(in: context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        
        
        pdfContext.saveGState()
        //CGContextTranslateCTM(pdfContext, webView.frame.origin.x, webView.frame.origin.x) // where the view should be shown
        pdfContext.translateBy(x: largeWebView.frame.origin.x, y: largeWebView.frame.origin.x)
        //CGContextScaleCTM(pdfContext, 1/rescale, 1/rescale)
        pdfContext.scaleBy(x: 1/rescale, y: 1/rescale)
        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: bigSize)
        image?.draw(in: frame)
        
        pdfContext.restoreGState()
        
       
        UIGraphicsEndPDFContext()
       
        
       
        let fileName = "pdffilename.pdf"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0] as! NSString
        let outputURL = documentsDirectory.appending("/" + fileName)
        pdfData.write(toFile: outputURL, atomically: true)
        if(pdfData != NSData()){
            
        }
       
       
        print("the frame is " + String(describing: largeWebView.frame))
        
        determineTutorial()
        
        
       
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadPDF(html: String, filePath:String) {
        
        
        let url = NSURL(fileURLWithPath: filePath)
        let urlRequest = NSURLRequest(url: url as URL)
        
        
        
        largeWebView.loadHTMLString(html, baseURL: url as URL)
        webView.loadHTMLString(html, baseURL: url as URL)
        
        print("the frame is actually" + String(describing:largeWebView.scrollView.contentSize))
        largeWebView.frame = CGRect(x: 0, y: 0, width: largeWebView.scrollView.frame.width, height: largeWebView.scrollView.frame.height)
        var contentRect = CGRect.zero
        for view in self.webView.scrollView.subviews {
            contentRect = contentRect.union(view.frame) }
        self.webView.scrollView.contentSize = contentRect.size
        
        for view in self.largeWebView.scrollView.subviews {
            contentRect = contentRect.union(view.frame) }
        self.largeWebView.scrollView.contentSize = contentRect.size
        
        
        
    }
    
    
    /// The function that emails the resume to whatever email the user wants
    ///
    /// - Parameter sender: the Email icon button on the resume view screen
    @IBAction func emailResume(_ sender: Any) {
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        let scrollPoint = CGPoint(x: 0, y: webView.scrollView.contentSize.height - webView.frame.size.height + 50)
        self.webView.scrollView.setContentOffset(scrollPoint, animated: true)
        self.webView.reload()
        sendEmail()
        
        
    }
    
    func  webViewDidFinishLoad(_ webView: UIWebView) {
        
        self.isEmailing = false
        
    }
    private var isEmailing = false
    private func sendEmail() {
  
        userDefaultsDidChange()
        self.isEmailing = true
        self.webView.reload()
        //dataController.loadData()
        let firstname:String = dataController.getUser().firstName
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        // Configure the fields of the interface.
        composeVC.setToRecipients([dataController.getUser().emailAddress])
        composeVC.setSubject("Your Resume")
        composeVC.setMessageBody("Hello " + firstname + "," + "\n  \n" + "Attached below is your resume. We wish you sucess with your future career endeavours. \n \nThank you for choosing Resume Writer!\n", isHTML: false)
        
        
        
        
        let fileName = "pdffilename.pdf"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0] as! NSString
        let outputURL = URL(fileURLWithPath: documentsDirectory.appending("/" + fileName))
        
        
        let pdfData = NSData(contentsOf: outputURL)
        
        
        
        composeVC.addAttachmentData(pdfData as! Data, mimeType: "application/pdf", fileName: "resume.pdf")
        // Present the view controller modally.
        if(pdfData != nil){
            self.present(composeVC, animated: true, completion: nil)
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
}
