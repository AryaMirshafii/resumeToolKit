//
//  firstLoginScreen.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 10/25/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import Device
import EasyTipView


class firstLoginScreen: UIViewController, UITextFieldDelegate,EasyTipViewDelegate {
    func easyTipViewDidDismiss(_ tipView: EasyTipView) {
        //dont do anything. Check if entered text is still nil before incrementing tutorial progress
    }
    
    @IBOutlet weak var firstNameEntry: UITextField!
    
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var pleaseEnterNameLabel: UILabel!
    
    
    private var tipView:EasyTipView!
    private var dataController = newDataManager()
    private var infoController = userInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.firstNameEntry.delegate = self
        self.firstNameEntry.clearButtonMode = .whileEditing
        //self.icon.isHidden = true
        self.firstNameEntry.becomeFirstResponder()
       
        
        initializeTipView()
        
        
    

    }
    
    
    func initializeTipView(){
        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = UIFont(name: "Futura-Medium", size: 20)!
        preferences.drawing.foregroundColor = UIColor.white
        preferences.drawing.backgroundColor = UIColor(hue:0.46, saturation:0.99, brightness:0.6, alpha:1)
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.top
        
        
        preferences.drawing.arrowHeight = 30
        preferences.drawing.arrowWidth = 30
        /*
         * Optionally you can make these preferences global for all future EasyTipViews
         */
        
        EasyTipView.globalPreferences = preferences
        tipView = EasyTipView(text: "Press enter when you are done typing", preferences: preferences)
        tipView.show(forView: self.firstNameEntry, withinSuperview: self.view)
    }
    
    
    
    
    ///  When enter/return is pressed in keyboard, entered data is saved and segue is preformed to the next sceen
    ///
    /// - Parameter textField:
    /// - Returns: true when enter is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tipView.dismiss()
        dataController.savefirstName(firstName: firstNameEntry.text!)
        
        
        textField.resignFirstResponder()
        //dismiss(animated: true, completion: nil)
        infoController.incrementTutorialProgress()
        
        performSegue(withIdentifier: "1to2", sender: self)
        
        
        
        return true
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        tipView.dismiss()
        if segue.identifier == "1to2" {
            print("1to2")
  
        }
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
