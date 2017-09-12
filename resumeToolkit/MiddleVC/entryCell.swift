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
    self.entryDescription.layer.cornerRadius = 20
    }
}
