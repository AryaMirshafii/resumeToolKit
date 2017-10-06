//
//  entryCell.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/7/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit
class entryCell : UITableViewCell{
    
    
    @IBOutlet weak var entryName: UILabel!
    
    @IBOutlet weak var entryDescription: UITextView!
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /**
        self.entryDescription.layer.cornerRadius = 25
        self.entryDescription.layer.borderWidth = 2
        self.entryDescription.layer.borderColor = UIColor(red:0.00, green:0.40, blue:0.80, alpha:1.0).cgColor
        self.entryDescription.isUserInteractionEnabled = false
        
         */
        self.entryName.textColor = UIColor(red:0.00, green:0.40, blue:0.80, alpha:1.0)
        self.entryDescription.isUserInteractionEnabled = false
        self.layer.borderWidth = 20
        self.layer.borderColor = UIColor.clear.cgColor
        self.entryDescription.backgroundColor = UIColor(red:0.77, green:0.79, blue:0.83, alpha:1.0)
        
       
    }
    
    func getColor(aNumber: Int){
        
        
        //light = UIColor(red:0.71, green:0.38, blue:0.50, alpha:1.0)
        //green UIColor(red:0.45, green:0.79, blue:0.29, alpha:1.0)
        if(aNumber == 0){
            colorView.backgroundColor = UIColor(red:0.23, green:0.42, blue:0.86, alpha:1.0)
        }
        if(aNumber == 1){
            colorView.backgroundColor = UIColor(red:0.71, green:0.38, blue:0.50, alpha:1.0)
        }
        if(aNumber == 2){
            colorView.backgroundColor = UIColor(red:0.45, green:0.79, blue:0.29, alpha:1.0)
        }
    }
}
