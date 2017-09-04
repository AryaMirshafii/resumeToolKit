//
//  middleView.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/1/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit
class middleView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        //performSegue(withIdentifier: "go", sender: indexPath)
    }
    
    @IBAction func leaveLogin(_ sender: Any) {
        performSegue(withIdentifier: "exitLogin", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "exitLogin" {
            
        }
    }
    
}
