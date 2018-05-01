//
//  extracurricular.swift
//  resumeWriterPro
//
//  Created by Arya Mirshafii on 1/1/18.
//  Copyright © 2018 georgiaTechEngineeringForInnovationGroup. All rights reserved.
//

import Foundation
class extracurricular:course {
    var year:String
    init(name: String, entryType: String, description: String, year:String) {
        self.year = year
        super.init(name: name, entryType: entryType, description: description)
    }
    
    
}
