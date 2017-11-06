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

class pdfView: UIViewController,UIScrollViewDelegate {
    var pdfGenerate = testPDFGenerator()
    var userInfoController = userInfo()
    var previousFilePath = " "
    
    
    //getfilepath ==
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var resumeNameLabel: UILabel!
    
    @IBOutlet weak var userSelect: ASHorizontalScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaultsDidChange()
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
       
        //previousFilePath = userInfoController.getFilePath()
        //self.loadPDF(filePath: pdfGenerate.createPDFFileAndReturnPath())
        self.webView.isOpaque = true
        self.webView.backgroundColor = UIColor.clear
        let button1 = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 140))
        let button2 = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 140))
        let button3 = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 140))
        let button4 = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 140))
        button1.backgroundColor = UIColor.purple
        button2.backgroundColor = UIColor.red
        
        button3.backgroundColor = UIColor.purple
        button4.backgroundColor = UIColor.red
        userSelect.uniformItemSize = CGSize(width: 90, height: 140)
        userSelect.setItemsMarginOnce()
        
        
        
        userSelect.addItems([button1,button2,button3,button4])
       
        //userSelect.marginSettings = MarginSettings(leftMargin: <#T##CGFloat#>, numberOfItemsPerScreen: <#T##Float#>)
        
        
        
        
       
        
        //userSelect.showsHorizontalScrollIndicator = true
        self.userSelect.clipsToBounds = true
        
       // self.webView.scrollView.zoomScale = -2.0
        
        //self.webView.scrollView.setZoomScale( 5.0, animated: false)
        
        var contentRect = CGRect.zero
        for view in self.webView.scrollView.subviews {
            contentRect = contentRect.union(view.frame) }
        self.webView.scrollView.contentSize = contentRect.size
        
        self.userSelect.delegate = self
        self.userSelect.bounces = true
        
        
    
        //let notificationCenter = NotificationCenter.default
        //notificationCenter.addObserver(self, selector: #selector(self.userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
        
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
        self.webView.frame = CGRect(x: 0, y: -154, width: 375, height: 608)
        //self.webView.frame =  CGRect(x: -237, y: -300, width: 612, height: 792)
        //self.webView.bounds =  CGRect(x:0, y: 0, width: 612, height: 792)
        //webView.layoutIfNeeded()
        //self.webView.bounds =  CGRect(x: 0, y: 0, width: 612, height: 792)
        loadPDF(html: pdfResult.html, filePath: String(describing: pdfResult.output))
        
        UIGraphicsBeginPDFContextToData(pdfData, webView.bounds, nil)
        defer { UIGraphicsEndPDFContext() }
        UIGraphicsBeginPDFPage()
        
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return }
        
        let rescale: CGFloat = 6
        
        func scaler(v: UIView) {
            if !v.isKind(of:UIStackView.self) {
                v.contentScaleFactor = 8
            }
            for sv in v.subviews {
                scaler(v: sv)
            }
        }
        scaler(v: self.webView)
        
        let bigSize = CGSize(width: webView.frame.size.width*rescale, height: webView.frame.size.height*rescale)
        UIGraphicsBeginImageContextWithOptions(bigSize, true, 1)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(UIColor.white.cgColor)
        context.fill(CGRect(origin: CGPoint(x: 0, y: 0), size: bigSize))
        
        // Must increase the transform scale
        //CGContextScaleCTM(context, rescale, rescale)
        context.scaleBy(x: rescale, y: rescale)
        webView.layer.render(in: context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //let page = CGRect(x: 0, y: -300, width: 612, height: 792)
        
        
        pdfContext.saveGState()
        //CGContextTranslateCTM(pdfContext, webView.frame.origin.x, webView.frame.origin.x) // where the view should be shown
        pdfContext.translateBy(x: webView.frame.origin.x, y: webView.frame.origin.x)
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
        self.webView.frame = CGRect(x: 0, y: 0, width: 375, height: 462)
       // self.webView.bounds =  CGRect(x: 0, y: 0, width: 375, height: 462)
       
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPDF(html: String, filePath:String) {
        
        
        let url = NSURL(fileURLWithPath: filePath)
        let urlRequest = NSURLRequest(url: url as URL)
        
        
        webView.loadHTMLString(html, baseURL: url as URL)
        
        
        var contentRect = CGRect.zero
        for view in self.webView.scrollView.subviews {
            contentRect = contentRect.union(view.frame) }
        self.webView.scrollView.contentSize = contentRect.size
        
        
        
    }
    
    
    func createPdfFromView(aView: UIView, saveToDocumentsWithFileName fileName: String)
    {
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, aView.bounds, nil)
        UIGraphicsBeginPDFPage()
        
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return }
        
        aView.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
        
        if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let documentsFileName = documentDirectories + "/" + fileName
            debugPrint(documentsFileName)
            pdfData.write(toFile: documentsFileName, atomically: true)
        }
    }
    
    
    
}
