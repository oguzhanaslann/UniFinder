//
//  ProfileViewController.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 19.09.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var realProfileImageView: UIImageView!
    @IBOutlet weak var univerlistLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var profileImageDividerContainer: UIView!
    @IBOutlet weak var userfullNameText: UILabel!
    @IBOutlet weak var userEmailText: UILabel!
    @IBOutlet weak var userBioText: UILabel!
    @IBOutlet weak var userFullNameContainer: UIStackView!
    @IBOutlet weak var userBioContainer: UIStackView!
    
    private let viewModel : ProfileViewModel = {
        return Injector.shared.injectProfileViewModel()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        subscribeObservers()
    }
    
    private func initViews() {
        initBackgroundPhoto()
        initProfilePhoto()
        initEmailText()
        initBioText()
        initSettingButton()
        initLogOutButton()
    }
    private func initBackgroundPhoto() {
        profileImageView.tintColor = UIColor.gray
        profileImageView.layer.backgroundColor = UIColor.systemPink.withAlphaComponent(1.0).cgColor
    }
    private func initProfilePhoto() {
        realProfileImageView.tintColor = UIColor.gray
        realProfileImageView.layer.backgroundColor = UIColor.systemBlue.withAlphaComponent(1.0).cgColor
        realProfileImageView.layer.cornerRadius = realProfileImageView.frame.height / 2
        realProfileImageView.clipsToBounds = true
        realProfileImageView.layer.borderWidth = 2.5
        realProfileImageView.layer.borderColor = UIColor.white.cgColor

    }
    private func initEmailText() {
        userFullNameContainer.layer.borderColor = UIColor.systemPink.cgColor
        userFullNameContainer.layer.borderWidth = 1
        userFullNameContainer.layer.cornerRadius = 8
        userFullNameContainer.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        userFullNameContainer.isLayoutMarginsRelativeArrangement = true
    }
    private func initBioText() {
        userBioContainer.layer.borderColor = UIColor.systemPink.cgColor
        userBioContainer.layer.borderWidth = 1
        userBioContainer.layer.cornerRadius = 8
        userBioContainer.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        userBioContainer.isLayoutMarginsRelativeArrangement = true
    }
    private func initSettingButton() {
        univerlistLoginButton?.layer.masksToBounds = true
        univerlistLoginButton?.clipsToBounds = true
        univerlistLoginButton?.setTitle("Settings ", for: .normal)
        univerlistLoginButton?.layer.cornerRadius = 16
    }
    private func initLogOutButton() {
        googleLoginButton?.layer.masksToBounds = true
        googleLoginButton?.layer.borderWidth = 0.2
        googleLoginButton?.layer.borderColor = UIColor.gray.withAlphaComponent(0.8).cgColor
        googleLoginButton?.setTitle("Logout", for: .normal)
        googleLoginButton?.clipsToBounds = true
        googleLoginButton?.layer.cornerRadius = 16
    }
    
    private func subscribeObservers() {
        viewModel.userProfile.observe(on: self) { userProfileState in
            switch userProfileState {
                case .Error(let error):
                    break
                case .Success(let userProfile ):
                    self.onUserProfileDataReveiver(userProfile.data)
                    break
                case .Empty:
                    self.callUserProfileIfNotLoggedIn()
                    break
                case .Loading:
                    break
            }
        }
    }
    
    private func callUserProfileIfNotLoggedIn(){
        let isLoggedIn = self.viewModel.isLoggedIn()
        if isLoggedIn {
            let userId = self.viewModel.getUserId()
            self.viewModel.getUserProfile(userId)
        }
    }
    
    private func onUserProfileDataReveiver(_ userProfile : UserProfile) {
        profileImageView.kf.setImage(with: URL(string: userProfile.backgroundPhoto))
        realProfileImageView.kf.setImage(with: URL(string: userProfile.profilePhoto))
        userfullNameText.text = userProfile.fullName
        userEmailText.text = userProfile.email
        userBioText.text = userProfile.bio
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let shouldShowLoginDialog = viewModel.isLoggedIn().not()
        if shouldShowLoginDialog {
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
            
            dialog.showOn(self, isAnimated: true)
        }
    }
    
  
}
