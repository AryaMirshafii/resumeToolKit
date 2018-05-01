//
//  course.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/15/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation

class course: resumeItem {
    var description: String
    init(name: String, entryType: String, description: String) {
        self.description = description
        super.init(name: name, entryType: entryType)
    }
    
}
