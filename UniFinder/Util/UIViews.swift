//
//  UIViews.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 16.10.2021.
//

import Foundation
import UIKit


func createGradientLayer(with frame : CGRect) -> CALayer{
    let gradient = CAGradientLayer()
    gradient.frame = frame
    gradient.colors = [UIColor.white.cgColor, UIColor.black.withAlphaComponent(0.5).cgColor]
    return gradient
}
