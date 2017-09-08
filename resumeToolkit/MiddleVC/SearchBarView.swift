//
//  SearchBarView.swift
//  searchTest
//
//  Created by arya mirshafii on 6/29/17.
//  Copyright © 2017 searchTest. All rights reserved.
//

import Foundation
import UIKit

class SearchBarView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        for subview in subviews {
            if !subview.isUserInteractionEnabled { continue }
            
            let newPoint = subview.convert(point, from: self)
            if subview.bounds.contains(newPoint) {
                return subview.hitTest(newPoint, with: event)
            }
        }
        return super.hitTest(point, with: event)
    }
}
