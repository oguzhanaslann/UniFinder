//
//  ProfileViewModel.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 11.12.2021.
//

import Foundation
import UIKit

class ProfileViewModel : ViewModel {
    let userProfile = Observable<DataState<UserProfile>>(DataState.getDefaultCase())
    
    private let repository : ProfileRepository
    
    init(repository : ProfileRepository) {
        self.repository = repository
    }
    
    func isLoggedIn() -> Bool {
        return repository.isUserLoggedIn()
    }
    
    func getUserId() -> Int {
        return 0 
    }
    
    func getUserProfile(_ id : Int) {
        
    }
}
