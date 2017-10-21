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

class pdfView: UIViewController {
    var pdfGenerate = testPDFGenerator()
    var userInfoController = userInfo()
    var previousFilePath = " "
    //getfilepath ==
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaultsDidChange()
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
       
        //previousFilePath = userInfoController.getFilePath()
        //self.loadPDF(filePath: pdfGenerate.createPDFFileAndReturnPath())
        self.webView.isOpaque = true
        self.webView.backgroundColor = UIColor.clear
        
    }
    var counter = 0
    @objc func userDefaultsDidChange() {
        print("I AM WORKING")
        if(userInfoController.fetchData() == "main" && userInfoController.fetchChangeText() == "bbb" ){
            print("in1")
            let pdfResult = pdfGenerate.createPDFFileAndReturnPath()
            loadPDF(html: pdfResult.html, filePath: String(describing: pdfResult.output))
        }else if(userInfoController.fetchChangeText() != "bbb"){
            let pdfResult = pdfGenerate.createPDFFileAndReturnPath()
            loadPDF(html: pdfResult.html, filePath: String(describing: pdfResult.output))
            
           
            
            
            
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPDF(html: String,filePath:String) {
        
        let url = NSURL(fileURLWithPath: filePath)
        let urlRequest = NSURLRequest(url: url as URL)
        //webView.load(urlRequest as URLRequest)
        webView.loadHTMLString(html, baseURL: url as URL)
    }
    
    
    
}
