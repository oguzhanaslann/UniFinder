//
//  ProfileViewModel.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 11.12.2021.
//

import Foundation
import UIKit
import Combine

class ProfileViewModel : ViewModel {
    let userProfile = Observable<DataState<UserProfile>>(DataState.getDefaultCase())
    let userProfileSettings  = Observable<DataState<[ProfileSetting]>>(DataState.getDefaultCase())
    
/**
 let subject = PassthroughSubject<ProfileSetting, Never>()
 
 let publisher :  Publishers.Share<PassthroughSubject<ProfileSetting, Never>>
 */
    
    let subject = PassthroughSubject<ProfileSetting, Never>()

    let publisher: AnyPublisher<ProfileSetting, Never>
    
    
    
    private static let LanguageSettingsPosition : Int = 0
    private static let ContanctSettingsPosition : Int = 1
    private static let PrivacyAndAgreementSettingsPosition : Int = 2
    private static let LogoutSettingsPosition : Int = 3
    
    
    private let repository : ProfileRepository
    
    init(repository : ProfileRepository) {
        self.repository = repository
        publisher = subject.eraseToAnyPublisher()
    }
    
    func isLoggedIn() -> Bool {
        return repository.isUserLoggedIn() || true 
    }
    
    func getUserId() -> Int {
        return 0 
    }
    
    func getUserProfile(_ id : Int) {
        
    }
    
    
    func getProfileSettings() {
        userProfileSettings.value = DataState.Success(
            DataContent.createFrom(
                data:  [
                    ProfileSetting.Language,
                    ProfileSetting.Contanct,
                    ProfileSetting.PrivacyAndAgreement,
                    ProfileSetting.Logout
                ]
            )
        )
    }
    
    func onSettingsDidTab(at position: Int ) {
        switch position {
            case ProfileViewModel.LanguageSettingsPosition :
            subject.send(ProfileSetting.Language)
                break
            case ProfileViewModel.ContanctSettingsPosition :
            subject.send(ProfileSetting.PrivacyAndAgreement)
                break
            case ProfileViewModel.PrivacyAndAgreementSettingsPosition :
            subject.send(ProfileSetting.Contanct)
                break
            case ProfileViewModel.LogoutSettingsPosition :
            subject.send(ProfileSetting.Logout)
                break
            default:
                break
        }
        

     
    }
    
    func logoutUser() {
        
    }
    
   
    /*
     let dialog = createAlertDialog(
         title: "Warning",
         message: "You are about to log out",
         style: UIAlertController.Style.alert,
         actions: UIAlertAction(
             title: "Are you sure about logging out ",
             style: UIAlertAction.Style.default,
             handler: { action in
                 
             }
         )
     )
     
     dialog.showOn(self, isAnimated: true)
     
     */
     
}
