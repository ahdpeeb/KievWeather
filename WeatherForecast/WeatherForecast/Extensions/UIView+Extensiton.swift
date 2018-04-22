//
//  UIView.swift
//  CityTradesman
//
//  Created by Yakiv Kovalsky on 7/19/17.
//  Copyright © 2017 perpet.io. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(radius: Float? = nil) {
        clipsToBounds = true
        layer.cornerRadius = radius != nil ? CGFloat(radius!) : min(bounds.height, bounds.width) / 2
    }
    
    func roundSides() {
        let height = self.bounds.height
        self.roundCorners(radius: Float(height / 2))
    }
}
