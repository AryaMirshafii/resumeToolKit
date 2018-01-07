//
//  experienceCell.swift
//  resumeWriterPro
//
//  Created by Arya Mirshafii on 1/1/18.
//  Copyright © 2018 georgiaTechEngineeringForInnovationGroup. All rights reserved.
//

import Foundation
class experienceCell:resumeCell {
    @IBOutlet weak var positionlabel: UILabel!
    @IBOutlet weak var startYearLabel: UILabel!
    @IBOutlet weak var endYearLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var experienceDescription: UITextView!
    @IBOutlet weak var contactLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor(red:0.23, green:0.42, blue:0.86, alpha:1.0)
        experienceDescription.backgroundColor = .clear
        
    }
    
    
}
