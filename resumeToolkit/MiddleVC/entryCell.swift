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
    override func awakeFromNib() {
        super.awakeFromNib()
        self.entryDescription.layer.cornerRadius = 25
        self.entryDescription.layer.borderWidth = 2
        self.entryDescription.layer.borderColor = UIColor(red:0.00, green:0.40, blue:0.80, alpha:1.0).cgColor
        self.entryDescription.isUserInteractionEnabled = false
        self.layer.borderWidth = 20
        self.layer.borderColor = UIColor.clear.cgColor
        
       
    }
}
