//
//  ProfileViewController.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 19.09.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var univerlistLoginButton: UIButton!
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.tintColor = UIColor.gray
        let screenSize  = self.view.frame.size 
        
        univerlistLoginButton?.layer.masksToBounds = true
        univerlistLoginButton?.clipsToBounds = true
        univerlistLoginButton?.layer.cornerRadius = 16
        
        facebookLoginButton?.layer.masksToBounds = true
        facebookLoginButton?.clipsToBounds = true
        facebookLoginButton?.layer.cornerRadius = 16
        
        googleLoginButton?.layer.masksToBounds = true
        googleLoginButton?.layer.borderWidth = 0.2
        googleLoginButton?.layer.borderColor = UIColor.gray.withAlphaComponent(0.8).cgColor
        googleLoginButton?.clipsToBounds = true
        googleLoginButton?.layer.cornerRadius = 16
        
        
     
        let dialog = createAlertDialog(
            title: "Title",
            message: "Message",
            style: UIAlertController.Style.alert,
            actions: UIAlertAction(
                title: "Click",
                style: UIAlertAction.Style.default,
                handler: nil
            )
        )
//        self.present(dialog, animated: true, completion: nil)
        dialog.showOn(self, isAnimated: true)
    }
    


}
