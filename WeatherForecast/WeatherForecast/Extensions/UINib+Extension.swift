//
//  UIView + Extension.swift
//  CityTradesman
//
//  Created by Nikola Andriiev on 2/1/17.
//  Copyright © 2017 iosDeveloper. All rights reserved.
//

import UIKit

public extension UINib {
    public class func nibName(_ name: String) -> UINib? {
        return UINib(nibName: name, bundle: Bundle.main)
    }
    
    public class func controller<T: UIViewController>(controller: T.Type, owner: AnyObject? = nil) -> T {
        let stringClass = String(describing: controller)
        let nib = self.nibName(stringClass)
        guard let controller = nib?.instantiate(withOwner: owner, options: nil).first as? T else {
             fatalError("The nib \(String(describing: nib)) expected its viewController to be of type \(T.self)")
        }
        
        return controller
    }
    
    public class func view<T: UIView>(_ view: T.Type, owner: AnyObject? = nil) -> T {
        let stringClass = String(describing: view)
        let nib = self.nibName(stringClass)
        
        guard let view = nib?.instantiate(withOwner: owner, options: nil).first as? T else {
            fatalError("The nib \(String(describing: nib)) expected its root view to be of type \(T.self)")
        }
        
        return view
    }
}
