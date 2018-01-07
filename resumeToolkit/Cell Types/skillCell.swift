//
//  skillCell.swift
//  resumeWriterPro
//
//  Created by Arya Mirshafii on 1/1/18.
//  Copyright © 2018 georgiaTechEngineeringForInnovationGroup. All rights reserved.
//

import Foundation
class skillCell: resumeCell{
    @IBOutlet weak var skillNameLabel: UILabel!
    @IBOutlet weak var skillDescription: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor(red:0.82, green:0.65, blue:0.06, alpha:1.0)
    }
    
}
