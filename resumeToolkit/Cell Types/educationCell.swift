//
//  educationCell.swift
//  resumeWriterPro
//
//  Created by Arya Mirshafii on 1/1/18.
//  Copyright © 2018 georgiaTechEngineeringForInnovationGroup. All rights reserved.
//

import Foundation

class educationCell: resumeCell{
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var schoolStartYearLabel: UILabel!
    @IBOutlet weak var schoolEndYearLabel: UILabel!
    @IBOutlet weak var degreeTypeLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        self.contentView.backgroundColor = UIColor(red:0.78, green:0.78, blue:0.96, alpha:1.0)
        self.tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tapRecognizer)
        tapRecognizer.isEnabled = false
        //tapRecognizer.disa
        print("CELL CREATED")
        
    }
    
    
    //Function is called when cell is toggled to be deleted
    //Allows the cell to be tapped, which allows the user to tap the delete button
    //on the cell
    func activateTaps(){
        print("activateTAPS is " + String(tapRecognizer.isEnabled))
        tapRecognizer.isEnabled = true
        
        
        
    }
    
    
    //Enables editing of the cell.
    //Lets say you mispell something, you can go back and edit it without re entering it.
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("longpressed")
        
        deleteInformation()
        
        tapRecognizer.isEnabled = false
        
    }
    
    
    
    
}
