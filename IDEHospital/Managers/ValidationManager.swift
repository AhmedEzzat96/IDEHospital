//
//  ValidationManager.swift
//  IDEHospital
//
//  Created by Ziad on 12/17/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

//MARK:- Enum
enum ValidationType {
    case name, email, phone, message, password
    
    var error: (title: String, message: String) {
        switch self {
            case .name:
                return (L10n.invalidName, L10n.nameRequirements)
        case .email:
            return (L10n.invalidEmail, L10n.emailRequiremtnts)
        case .phone:
            return (L10n.invalidPhoneNumber, L10n.phoneRequirements)
        case .message:
            return (L10n.missedData, L10n.dataRequirements)
        case .password:
            return (L10n.incorrectPassword, L10n.passwordRequirements)
        }
    }
}

class ValidationManager {
    
    // MARK:- Singleton
    private static let sharedInstance = ValidationManager()
    class func shared() -> ValidationManager {
        return ValidationManager.sharedInstance
    }
    
    // MARK:- Public Methods
    func isValid(with string: String?, validationType: ValidationType?) -> Bool {
        guard let string = string?.trimmed else {return false}
        switch validationType {
        case .email:
            if !string.isValidEmail || string.isEmpty {
                return false
            }
            return true
        case .password:
            if !string.isValidPassword || string.isEmpty {
                return false
            }
            return true
        case .name:
            if !string.isValidName || string.isEmpty {
                return false
            }
            return true
        case .phone:
            if !string.isValidPhone || string.isEmpty {
                return false
            }
            return true
        case .message:
            if string == L10n.enterDetails || string.isEmpty  {
                return false
            }
            return true
        case .none:
            return true
        }
    }
}
