//
//  Localization.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 17.12.2021.
//

import Foundation

enum Localization : String {
    case logoutWarning = "logoutwarning"
    case logoutWarningDescription = "logoutdarningdescription"
    case logout = "logout"
    case cancel = "cancel"
    case authenticationNeededTitle = "authenticationneededtitle"
    case signin = "signin"
    case signUp = "signup"
    case email = "email"
    case password = "password"
}

extension Localization {
    func localize(_ key : String? = nil) -> String {
        return NSLocalizedString( key ?? self.rawValue , comment: "")
    }
}
