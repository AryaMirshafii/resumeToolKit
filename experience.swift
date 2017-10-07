//
//  experience.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/7/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation

class experience: resumeItem{
    
    var dateStarted: String
    var dateEnded: String
    var companyName: String
    var companyContact: String
    
    
    init(name: String, dateStarted: String, dateEnded: String, companyName: String, companyContact: String, description: String){
        self.dateStarted = dateStarted
        self.dateEnded = dateEnded
        self.companyName = companyName
        self.companyContact = companyContact
        super.init(name: name, description: description)
        
        
        
        
        
    }
        
}
