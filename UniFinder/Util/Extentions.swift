//
//  Extentions.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 27.11.2021.
//

import Foundation
import UIKit


extension UIView {
    func hide() {
        self.isHidden = true
    }
    
    func show() {
        self.isHidden = false
    }
    
}

extension UIAlertController {
    func showOn(_ controller: UIViewController, isAnimated : Bool , completion: (() -> Void)? = nil) {
        controller.present(self, animated: isAnimated, completion: completion)
    }
}
