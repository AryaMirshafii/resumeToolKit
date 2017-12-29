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
import Device

class pdfView: UIViewController,UIScrollViewDelegate,MFMailComposeViewControllerDelegate,UIWebViewDelegate {
    var pdfGenerate = testPDFGenerator()
    var userInfoController = userInfo()
    var dataController = dataManager()
    var previousFilePath = " "
    
    
    //getfilepath ==
    
    @IBOutlet weak var largeWebView: UIWebView!
    
    
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var resumeNameLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var userSelect: ASHorizontalScrollView!
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
        
        let button1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 140))
        let button2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 140))
        let button3 = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 140))
        let button4 = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 140))
        
        userSelect.uniformItemSize = CGSize(width: 90, height: 140)
        
        userSelect.marginSettings_375 =  MarginSettings(leftMargin: 20, miniMarginBetweenItems: 15, miniAppearWidthOfLastItem: 15)
        userSelect.marginSettings_768 =  MarginSettings(leftMargin: 40, miniMarginBetweenItems: 30, miniAppearWidthOfLastItem: 20)
        userSelect.marginSettings_414 =  MarginSettings(leftMargin: 30, miniMarginBetweenItems: 15, miniAppearWidthOfLastItem: 20)
        
        userSelect.clipsToBounds = true
        
        button1.image = #imageLiteral(resourceName: "resume1Icon")
        button2.image = #imageLiteral(resourceName: "resume2Icon")
        button3.image = #imageLiteral(resourceName: "resume3Icon")
        button4.image = #imageLiteral(resourceName: "resume4Icon")
        
        
        
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
        
        
    
        
        if(userInfoController.getResumeIndex() == "0"){
            resumeNameLabel.text = "Plain"
            userSelect.contentOffset.x = 0 * (userSelect.frame.size.width/3.5)
            
            
        } else if(userInfoController.getResumeIndex() == "1"){
            resumeNameLabel.text = "Industrial"
            userSelect.contentOffset.x = 1 * (userSelect.frame.size.width/3.5)
            
        } else if(userInfoController.getResumeIndex() == "2") {
            resumeNameLabel.text = "Modern Minimalist"
            userSelect.contentOffset.x = 2 * (userSelect.frame.size.width/3.5)
        }
        else if(userInfoController.getResumeIndex() == "3") {
            resumeNameLabel.text = "Vibrant Modern"
            userSelect.contentOffset.x = 3 * (userSelect.frame.size.width/3.5)
        }
        
        
        
        
        
        
    }
    
    
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        perform(#selector(self.actionOnFinishedScrolling), with: nil, afterDelay: Double(velocity.x))
    }
    @objc func actionOnFinishedScrolling() {
        print("scrolling is finished")
        let resumeToPick = String(Int(abs(round(userSelect.contentOffset.x / (userSelect.frame.size.width/3.5)))))
        print("THE INDEX IS" + resumeToPick + userInfoController.getResumeIndex())
        userInfoController.saveResumeIndex(resumeIndexAt: resumeToPick)
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
        
        
        if (Device.isPad()){
            print("It's an iPad")
            self.webView.frame = CGRect(x: 0, y: 0, width: 768, height: 785)
        }
       
    }
    
    
    
    
    
    
    
    var counter = 0
    @objc func userDefaultsDidChange() {
        print("I AM WORKING")
        
        
        
        let pdfResult = pdfGenerate.createPDFFileAndReturnPath(indexAt: userInfoController.getResumeIndex())
        if(userInfoController.fetchData() == "main" && userInfoController.fetchChangeText() == "bbb" ){
            print("in1")
            
            //let pdfResult = pdfGenerate.createPDFFileAndReturnPath(indexAt: userInfoController.getResumeIndex())
            loadPDF(html: pdfResult.html, filePath: String(describing: pdfResult.output))
        }else if(userInfoController.fetchChangeText() != "bbb"){
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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPDF(html: String, filePath:String) {
        
        
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
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        self.isEmailing = false
        
    }
    var isEmailing = false
    func sendEmail() {
  
        userDefaultsDidChange()
        self.isEmailing = true
        self.webView.reload()
        dataController.loadData()
        let firstname:String = dataController.user.last?.value(forKey: "firstName") as! String
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        // Configure the fields of the interface.
        composeVC.setToRecipients(["aryamirshafii97@gmail.com"])
        composeVC.setSubject("Your Resume")
        composeVC.setMessageBody("Hello " + firstname + "," + "\n  \n" + "Attached below is your resume. We wish you sucess with your future career endeavours. \n \nThank you for choosing Resume Writer!\n", isHTML: false)
        
        
        
        
        let fileName = "pdffilename.pdf"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0] as! NSString
        let outputURL = URL(fileURLWithPath: documentsDirectory.appending("/" + fileName))
        
        
        let pdfData = NSData(contentsOf: outputURL)
        
        
        
        composeVC.addAttachmentData(pdfData as! Data, mimeType: "application/pdf", fileName: "resume.pdf")
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
}
