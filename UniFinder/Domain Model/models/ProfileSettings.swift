//
//  ProfileSettings.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 17.12.2021.
//

import Foundation

enum ProfileSetting : String  {
    case Language = "Language"
    case Contanct = "Contanct"
    case PrivacyAndAgreement = "Privacy And Agreement"
    case Logout = "Logout"
}

extension ProfileSetting {
    func localizedRawValue() -> String {
        return NSLocalizedString(self.rawValue.lowercased().trimmingCharacters(in: .whitespacesAndNewlines), comment: "")
    }
}
