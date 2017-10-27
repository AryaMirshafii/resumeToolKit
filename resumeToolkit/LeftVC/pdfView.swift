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

class pdfView: UIViewController {
    var pdfGenerate = testPDFGenerator()
    var userInfoController = userInfo()
    var previousFilePath = " "
    
    //getfilepath ==
    @IBOutlet weak var webView: WKWebView!
    
    
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
        let button1 = UIButton(frame: CGRect.zero)
        let button2 = UIButton(frame: CGRect.zero)
        let button3 = UIButton(frame: CGRect.zero)
        let button4 = UIButton(frame: CGRect.zero)
        button1.backgroundColor = UIColor.purple
        button2.backgroundColor = UIColor.red
        
        button3.backgroundColor = UIColor.purple
        button4.backgroundColor = UIColor.red
        
        userSelect.addItems([button1,button2,button3,button4])
        
        let scrollDetect = UITapGestureRecognizer(target: self, action: #selector(self.enableTouches(_:)))
        let mainviewTouches = UITapGestureRecognizer(target: self, action: #selector(self.cancelTouchesInMainView(_:)))
        self.view.addGestureRecognizer(scrollDetect)
        self.userSelect.addGestureRecognizer(mainviewTouches)
        
        userSelect.showsHorizontalScrollIndicator = true
        self.userSelect.clipsToBounds = true
        
        
        
        
    }
    
    
    @objc func cancelTouchesInMainView(_ sender: UITapGestureRecognizer) {
        print("trying to scroll view")
        //self.view.isUserInteractionEnabled = false
        
    }
    
    @objc func enableTouches(_ sender: UITapGestureRecognizer) {
        print("main view")
        //self.view.isUserInteractionEnabled = true
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
    
    func loadPDF(html: String, filePath:String) {
        
        let url = NSURL(fileURLWithPath: filePath)
        let urlRequest = NSURLRequest(url: url as URL)
        //webView.load(urlRequest as URLRequest)
        webView.loadHTMLString(html, baseURL: url as URL)
        
        
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
