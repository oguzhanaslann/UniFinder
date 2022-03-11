//
//  LoginViewController.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 13.12.2021.
//

import Foundation
import UIKit
import SwiftUI

class LoginViewController : ViewController {
    

    let signInLabel : UILabel = {
        let myLabel = UILabel()
        myLabel.enableAutoLayout()
        myLabel.text = Localization.signin.localize()
        myLabel.textAlignment = .left
        myLabel.font = myLabel.font.withSize(36)
        return myLabel
    }()
    
    let emailHeader : UILabel = {
        let myLabel = UILabel()
        myLabel.enableAutoLayout()
        myLabel.text = Localization.email.localize()
        myLabel.textAlignment = .left
        myLabel.font = UIFont(name:"AvenirNext-Bold",size:18)
        return myLabel
    }()
    
    
    
    let emailTextField : UITextField = {
        let myTextField: UITextField = UITextField()
        myTextField.enableAutoLayout()
        myTextField.placeholder = "Enter your email..."
        myTextField.text = "your@email.com"
        myTextField.backgroundColor = .white
        myTextField.textColor = .black
        myTextField.layer.masksToBounds = true
        myTextField.layer.borderWidth = 0.2
        myTextField.clipsToBounds = true
        myTextField.layer.cornerRadius = 24
        myTextField.keyboardType = .default
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 30))
        myTextField.leftView = paddingView
        myTextField.rightView = paddingView
        myTextField.leftViewMode = .always
        myTextField.rightViewMode = .always
        return myTextField
    }()
    
    let emailErrorText: UILabel = {
        let myLabel = UILabel()
        myLabel.enableAutoLayout()
        myLabel.text = Localization.password.localize()
        myLabel.textAlignment = .left
        myLabel.textColor = .systemRed
        myLabel.font = UIFont(name:"AvenirNext-Medium",size:18)
        return myLabel
    }()
    
    
    let passwordHeader : UILabel = {
        let myLabel = UILabel()
        myLabel.enableAutoLayout()
        myLabel.text = Localization.password.localize()
        myLabel.textAlignment = .left
        myLabel.font = UIFont(name:"AvenirNext-Bold",size:18)
        
        return myLabel
    }()
    
    
    
    let passwordTextField : UITextField = {
        let myTextField: UITextField = UITextField()
        myTextField.enableAutoLayout()
        myTextField.placeholder = "Enter your password..."
        myTextField.backgroundColor = .white
        myTextField.textColor = .black
        myTextField.layer.masksToBounds = true
        myTextField.isSecureTextEntry = true
        myTextField.layer.borderWidth = 0.2
        myTextField.clipsToBounds = true
        myTextField.textContentType = .password
        myTextField.layer.cornerRadius = 24
        myTextField.keyboardType = .default
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 30))
        myTextField.leftView = paddingView
        myTextField.rightView = paddingView
        
        myTextField.leftViewMode = .always
        myTextField.rightViewMode = .always
        return myTextField
    }()
    
    let signInButton : UIButton = {
        let signInButton = UIButton()
        signInButton.enableAutoLayout()
        signInButton.backgroundColor = .systemRed
        signInButton.tintColor = .systemRed
        signInButton.setTitle(Localization.signin.localize(),for: .normal)
        signInButton.layer.cornerRadius = 12
        signInButton.clipsToBounds = true
        return signInButton
    }()
    
    
    let agreementsInformationText : UILabel = {
        let label = UILabel()
        label.enableAutoLayout()
        label.textAlignment = .left
        label.font =  UIFont(name:"AvenirNext-Medium",size:12)
        
        let plainAttributedString = NSMutableAttributedString(string: "This is a link: ", attributes: nil)
        let attributedLinkString = NSMutableAttributedString(string: "string", attributes:[NSAttributedString.Key.link: URL(string: "http://www.google.com")!])
        
        let fullAttributedString = NSMutableAttributedString()
        fullAttributedString.append(plainAttributedString)
        fullAttributedString.append(attributedLinkString)
        label.isUserInteractionEnabled = true
        label.attributedText = fullAttributedString
        
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(signInLabel)
        view.addSubview(emailTextField)
        view.addSubview(emailHeader)
        view.addSubview(passwordHeader)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(agreementsInformationText)
        view.addSubview(emailErrorText)
        
        signInLabel.getConstraintBuilder()
            .appendConstarint(
                signInLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 32)
            ).appendConstarint(
                signInLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 16)
            ).appendConstarint(
                signInLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: 16)
            ).activate()
        
        
        emailHeader.getConstraintBuilder()
            .appendConstarint(
                emailHeader.topAnchor.constraint(equalTo: signInLabel.bottomAnchor,constant: 64)
            ).appendConstarint(
                emailHeader.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 16)
            ).appendConstarint(
                emailHeader.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -16)
            )
            .activate()
        
        emailTextField.getConstraintBuilder()
            .appendConstarint(
                emailTextField.topAnchor.constraint(equalTo: emailHeader.bottomAnchor,constant: 8)
            ).appendConstarint(
                emailTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 16)
            ).appendConstarint(
                emailTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -16)
            ).appendConstarint(
                emailTextField.heightAnchor.constraint(greaterThanOrEqualTo: signInLabel.heightAnchor, multiplier: 1)
            ).activate()
        
        
        emailErrorText.getConstraintBuilder()
            .appendConstarint(
                emailErrorText.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,constant: 8)
            ).appendConstarint(
                emailErrorText.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 16)
            ).appendConstarint(
                emailErrorText.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -16)
            )
            .activate()
        
        passwordHeader.getConstraintBuilder()
            .appendConstarint(
                passwordHeader.topAnchor.constraint(equalTo: emailErrorText.bottomAnchor,constant: 16)
            ).appendConstarint(
                passwordHeader.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 16)
            ).appendConstarint(
                passwordHeader.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -16)
            ).activate()
        
        
        passwordTextField.getConstraintBuilder()
            .appendConstarint(
                passwordTextField.topAnchor.constraint(equalTo: passwordHeader.bottomAnchor,constant: 8)
            ).appendConstarint(
                passwordTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 16)
            ).appendConstarint(
                passwordTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -16)
            ).appendConstarint(
                passwordTextField.heightAnchor.constraint(greaterThanOrEqualTo: signInLabel.heightAnchor, multiplier: 1)
            ).activate()
        
        signInButton.getConstraintBuilder()
            .appendConstarint(
                signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -64)
            ).appendConstarint(
                signInButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 16)
            ).appendConstarint(
                signInButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -16)
            ).appendConstarint(
                signInButton.heightAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.10)
            ).activate()
        
        agreementsInformationText.getConstraintBuilder()
            .appendConstarint(
                agreementsInformationText.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,constant: 16)
            ).appendConstarint(
                agreementsInformationText.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 16)
            ).appendConstarint(
                agreementsInformationText.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -16)
            ).activate()
        
        
        signInButton.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
        
    }
    
   
    @objc private func action(sender: UIButton) {
        emailErrorText.removeFromSuperview()
        passwordHeader.getConstraintBuilder()
            .appendConstarint(
                passwordHeader.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,constant: 16)
            ).appendConstarint(
                passwordHeader.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 16)
            ).appendConstarint(
                passwordHeader.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -16)
            ).activate()
        
        print("test")
    }
    
}
