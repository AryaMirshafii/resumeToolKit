//
//  resumeCell.swift
//  resumeWriterPro
//
//  Created by Arya Mirshafii on 1/1/18.
//  Copyright © 2018 georgiaTechEngineeringForInnovationGroup. All rights reserved.
//

import Foundation
class resumeCell:UITableViewCell,UITextViewDelegate {
    var cellType = " "
    var originalText = " "
    
    var dataController = newDataManager()
    var infoController = userInfo()
    var tapRecognizer:UITapGestureRecognizer!
    
    func getOriginalText() -> String { return ""}
    func deleteInformation(){}
    
}
