//
//  experience.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/7/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation

class experience: resumeItem{
    
    var yearStarted: String
    var yearEnded: String
    var companyName: String
    var description:String
    var companyContact: String
    
    
    
    init(name: String, entryType: String,yearStarted:String, yearEnded:String,companyName:String,description:String,companyContact:String) {
        self.yearStarted = yearStarted
        self.yearEnded = yearEnded
        self.companyName = companyName
        self.description = description
        self.companyContact =  companyContact
        super.init(name: name, entryType: entryType)
    }
        
}
