//
//  resumeItemCell.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 12/10/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit

class resumeItemCell:UITableViewCell {
    
    @IBOutlet weak var entryDescriptionField: UITextView!
    @IBOutlet weak var itemNameLabel: UILabel!
    override func awakeFromNib() {
        self.entryDescriptionField.layer.cornerRadius = 10
    }
}
