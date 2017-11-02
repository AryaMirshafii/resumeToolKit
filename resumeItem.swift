//
//  resumeItem.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/7/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation

class resumeItem {
    var name: String
    var description: String
    var entryType: String
    
    init(name: String,description: String, entryType: String){
        self.name = name
        self.description = description
        self.entryType = entryType
    }
    
}
