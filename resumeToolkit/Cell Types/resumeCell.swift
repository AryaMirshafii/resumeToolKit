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
    
    var dataController = dataManager()
    var infoController = userInfo()
    @objc func longPressed(_ sender: UILongPressGestureRecognizer){}
    func getOriginalText() -> String { return ""}
    
}
