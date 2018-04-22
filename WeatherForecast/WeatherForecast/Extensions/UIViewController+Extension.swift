//
//  UIViewController + Extension.swift
//  Compas
//
//  Created by Nikola Andriiev on 01.11.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func getView<R>() -> R? {
        if #available(iOS 9.0, *) {
            return self.viewIfLoaded.flatMap { $0 as? R }
        } else {
            return self.isViewLoaded ? self as? R : nil
        }
    }
        
    func debagDealloc() {
        #if DEBUG
            print("\(String(describing: self)) dealloc")
        #endif
    }
    
    // add parent child relationship. controller.view will be embedded into "toContainerView
    func addChildViewControoler(_ controller: UIViewController, toContainerView view: UIView) {
        self.addChildViewController(controller)
        controller.view.frame = view.bounds;
        view.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
    }
    
    func removeChildViewController(_ controller: UIViewController) {
        if controller.view.superview != nil {
            controller.willMove(toParentViewController: nil)
            controller.view.removeFromSuperview()
            controller.removeFromParentViewController()
        }
    }
    
    func push(_ controller: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(controller, animated: animated)
    }
}
