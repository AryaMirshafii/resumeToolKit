//
//  courseCell.swift
//  resumeWriterPro
//
//  Created by Arya Mirshafii on 1/1/18.
//  Copyright © 2018 georgiaTechEngineeringForInnovationGroup. All rights reserved.
//

import Foundation
class courseCell:resumeCell{
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseDescription: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       self.contentView.backgroundColor = UIColor(red:0.71, green:0.38, blue:0.50, alpha:1.0)
    }
    
}
