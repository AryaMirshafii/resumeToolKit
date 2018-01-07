//
//  extracurricularCell.swift
//  resumeWriterPro
//
//  Created by Arya Mirshafii on 1/1/18.
//  Copyright © 2018 georgiaTechEngineeringForInnovationGroup. All rights reserved.
//

import Foundation

class extracurricularCell:resumeCell {
    
    @IBOutlet weak var extracurricularNameLabel: UILabel!
    @IBOutlet weak var extracurricularDescription: UITextView!
    @IBOutlet weak var extracurricularYearLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor(red:0.15, green:0.62, blue:0.11, alpha:1.0)
    }
    
}
