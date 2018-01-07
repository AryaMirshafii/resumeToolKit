//
//  education.swift
//  resumeWriterPro
//
//  Created by Arya Mirshafii on 1/1/18.
//  Copyright © 2018 georgiaTechEngineeringForInnovationGroup. All rights reserved.
//

import Foundation
class education: resumeItem {
    var startYear:String
    var endYear:String
    var degreeType:String
    var major:String
    
    init(name: String, entryType: String,startYear:String,endYear:String,degreeType:String,major:String) {
        self.startYear = startYear
        self.endYear = endYear
        self.degreeType = degreeType
        self.major = major
        super.init(name: name, entryType: entryType)
        
    }
    
}
