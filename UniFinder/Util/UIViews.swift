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
    gradient.colors = [UIColor.black.withAlphaComponent(0.5).cgColor,UIColor.white.withAlphaComponent(0.1).cgColor, UIColor.black.withAlphaComponent(0.8).cgColor]
    return gradient
}

func createProgressIndicator() -> UIActivityIndicatorView{
    let progressIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        return indicator
    }()
    
    return progressIndicator
}

/*
 self.present(alert, animated: true, completion: nil)
 */

func createAlertDialog(
    title:String,
    message:String,
    style:UIAlertController.Style,
    actions:UIAlertAction...) -> UIAlertController{
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    
    actions.forEach { action in
        alert.addAction(action)
    }

    return alert
}

