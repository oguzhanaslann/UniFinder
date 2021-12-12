//
//  UnifinderPreferences.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 12.12.2021.
//

import Foundation

class UniFinderPreferences {
    let preferences = UserDefaults.standard

    
    var isLoggedIn : Bool {
        get {
            preferences.bool(forKey:PreferenceKeys.IS_LOGGED_IN.rawValue)
        }
        set {
            preferences.setValue(newValue, forKey: PreferenceKeys.IS_LOGGED_IN.rawValue)
        }
    }
}

enum PreferenceKeys : String {
    case IS_LOGGED_IN  = "IS_LOGGED_IN"
}
