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

extension Bool {
    func not()  -> Bool {
        return !self
    }
}

extension String {
    func localize(_ key : String? = nil) -> String {
      return NSLocalizedString( key ?? self , comment: "")
    }
}

extension UIView {
    func enableAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func getConstraintBuilder() -> ConstraintBuilder {
        return ConstraintBuilder()
    }
}


class ConstraintBuilder {
    var constraints : [NSLayoutConstraint] = []
    
    func appendConstarint(_ constraint: NSLayoutConstraint) -> ConstraintBuilder {
        constraints.append(constraint)
        return self
    }
    
    func activate() {
        NSLayoutConstraint.activate(constraints)
        constraints = []
    }
}
