//
//  ProfileViewController.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 19.09.2021.
//

import UIKit
import Combine


class ProfileViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    

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
    
    
    private var settingsWindow : SettingsView?
    private var settings : [ ProfileSetting ] = []
    
    private var observer: AnyCancellable?
    
    private weak var dialog: UIAlertController?
    
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
    
    @IBAction func didTapSettings(_ sender: Any) {
        settingsWindow = SettingsView()
        settingsWindow?.present(on: self, with: "asdasd", with: "ads",delegate: self, dataSource: self)
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
        
        viewModel.userProfileSettings.observe(on: self) { profileSettingsState in
            switch profileSettingsState {
                case .Error(let error):
                    break
                case .Success(let settings ):
                    self.settings = settings.data
                    self.settingsWindow?.reloadData()
                    break
                case .Empty:
                    self.viewModel.getProfileSettings()
                    break
                case .Loading:
                    break
            }
        }
        
        observer = viewModel.publisher.receive(on: DispatchQueue.main).sink { onCompleted in
            
        } receiveValue: { setting in
            self.onSettingsClicked(setting)
        }

        
    }
    
    
    private func onSettingsClicked(_ setting : ProfileSetting ) {
        switch setting {
        case .Language:
            openLanguageSettingsPage()
        case .Contanct:
            openContanctPage()
        case .PrivacyAndAgreement:
            openPrivacyAndAgreementPage()
        case .Logout:
            logoutUser()
        }
    }
    
    func openLanguageSettingsPage() {
        
    }
    
    func openContanctPage() {
        
    }
    
    func openPrivacyAndAgreementPage() {
        
    }
    
    func logoutUser() {
        
        dialog = createAlertDialog(
            title: "Warning - You are about to log out",
            message: "are you sure about loggin out ? ",
            style: UIAlertController.Style.alert,
            actions: UIAlertAction(
                title: "Logout",
                style: UIAlertAction.Style.default,
                handler: { action in
                    self.viewModel.logoutUser()
                }
            ),
            UIAlertAction(
                title: "Cancel", style: UIAlertAction.Style.cancel, handler: { action in
                    self.dialog?.dismiss(animated: false, completion: nil)
                }
            )
        )
        
        dialog?.showOn(self, isAnimated: true)
        
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
            dialog = createAlertDialog(
                title: "Authentication needed",
                message: "Please login to you profile",
                style: UIAlertController.Style.alert,
                actions: UIAlertAction(
                    title: "Login",
                    style: UIAlertAction.Style.default,
                    handler: { action in
                        guard let viewController = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {
                            return
                        }
                        
                        viewController.modalPresentationStyle = .fullScreen
                        
                        self.present(viewController, animated: true , completion: nil)
                        
                    }
                )
            )
            
            dialog?.showOn(self, isAnimated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = settings[indexPath.row].rawValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.onSettingsDidTab(at: indexPath.row)
    }
    
}


class SettingsView  {
    
    
    struct Constants {
        static let backgroundAlphaTo : CGFloat = 0.6
        static let windowsWidthInitialRate = 0.45
        static let windowsHeightInitialRate = 0.25
        
        static let windowsWidthFinalRate = 0.90
        static let windowsHeightFinalRate = 0.75
    }
    
    private let backgroundView : UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    private let window : UIView = {
        let window : UIView = UIView()
        window.backgroundColor = .white
        window.layer.masksToBounds = true
        window.layer.cornerRadius = 16
        return window
    }()
    
    private let settingsTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        return table
    }()
    
    private var targetView : UIView?

    
    func present(
        on controller : UIViewController,
        with title : String,
        with message : String,
        delegate : UITableViewDelegate,
        dataSource : UITableViewDataSource
    ) {
       
        guard let  targetView = controller.view else {
            return
        }
        
        self.targetView = targetView
        targetView.addSubview(backgroundView)
        targetView.addSubview(window)
       
       
        
        settingsTableView.dataSource = dataSource
        settingsTableView.delegate = delegate
        

        
        setBackgroundViewSize()
        setWindowSize()
       
        UIView.animate(
            withDuration: 0.25,
            animations: {
                self.backgroundView.alpha = Constants.backgroundAlphaTo
                self.setWindowsSizeOnOpen()
                self.window.addSubview(self.settingsTableView)
                self.settingsTableView.contentInset = .init(top: 0, left: 12, bottom: 0, right: 0)
                self.settingsTableView.frame = CGRect(
                    x: 0,
                    y: 0,
                    width: self.window.bounds.width - 12 ,
                    height: self.window.bounds.height / 0.9
                )
                
                self.settingsTableView.rowHeight = UITableView.automaticDimension
            },
            completion: { isDone in
                let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.dismiss))
                self.backgroundView.addGestureRecognizer(gesture)
                self.settingsTableView.reloadData()
            }
        )
    }
    
    private func setWindowsSizeOnOpen() {
        guard let targetView = targetView else {
            return
        }
        
        let targetViewWidth = targetView.frame.size.width
        let targetViewHeight = targetView.frame.size.height
        self.window.frame = CGRect(x: targetView.center.x, y: targetView.center.y, width:(targetViewWidth * Constants.windowsWidthFinalRate ) , height: (targetViewHeight * Constants.windowsHeightFinalRate))
        self.window.center = targetView.center
    }
    
    private func setBackgroundViewSize(){
        guard let targetView = targetView else {
            return
        }
        backgroundView.frame = targetView.bounds
    }
    
    private func setWindowSize() {
        
        guard let targetView = targetView else {
            return
        }
        
        window.frame = CGRect(x: targetView.center.x, y: targetView.center.y, width:0 , height: 0)
        self.window.center = targetView.center
    }
    
     @objc func dismiss() {
        
        guard let targetView = targetView else {
            return
        }

        UIView.animate(
            withDuration: 0.25,
            animations:  {
                self.backgroundView.alpha = 0
                self.window.frame = CGRect(x: targetView.center.x, y: targetView.center.y, width: 0  , height: 0)
                self.window.center = targetView.center
            },
            completion: { isDone in
                
                if isDone {
                    self.backgroundView.removeFromSuperview()
                    self.window.removeFromSuperview()
                    self.settingsTableView.removeFromSuperview()
                }
                
            }
        )
    }
    
    func reloadData() {
        self.settingsTableView.reloadData()
    }
    
}
