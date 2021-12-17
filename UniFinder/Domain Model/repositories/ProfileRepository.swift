//
//  ProfileRepository.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 12.12.2021.
//

import Foundation
import UIKit

class ProfileRepository : Repository {
    private let preferences : UniFinderPreferences
    
    init(preferences: UniFinderPreferences) {
        self.preferences = preferences
    }
    
    func isUserLoggedIn() -> Bool {
        return preferences.isLoggedIn
    }
    
    func logoutUser() {
        
    }
    
    
}
