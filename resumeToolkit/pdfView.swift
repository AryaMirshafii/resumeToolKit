//
//  pdfView.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/7/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit

class pdfView:UIViewController {
    var pdfGenerate = testPDFGenerator()
    var userInfoController = userInfo()
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaultsDidChange()
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(self.userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
        webView.scalesPageToFit = true
        
    }
    
    @objc func userDefaultsDidChange() {
        if(userInfoController.fetchData() == "main"){
            loadPDF(filePath: pdfGenerate.createPDFFileAndReturnPath())
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPDF(filePath: String) {
        
        let url = NSURL(fileURLWithPath: filePath)
        let urlRequest = NSURLRequest(url: url as URL)
        webView.loadRequest(urlRequest as URLRequest)
    }
    
    
    
}
