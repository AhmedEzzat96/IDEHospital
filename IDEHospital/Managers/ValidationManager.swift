//
//  ValidationManager.swift
//  IDEHospital
//
//  Created by Ziad on 12/17/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

enum ValidationError {
    case name(_ name: String?)
    case email(_ email: String?)
    case phone(_ phone: String?)
    case message(_ message: String?)
    case password(_ password: String?)
    case confirmPassword(_ confirmPassword: String?)
    
    var emptyField: Bool {
        switch self {
        case .name(let text), .email(let text), .password(let text), .message(let text), .phone(let text), .confirmPassword(let text):
            guard let trimmedText = text?.trimmed else { return false }
            return !trimmedText.isEmpty
        }
    }
    
    var validate: Bool {
        switch self {
        case .name(let name):
            return name!.isValidName
        case .email(let email):
            return email!.isValidEmail
        case .phone(let phone):
            return phone!.isValidPhone
        case .message(let message):
            return message != L10n.yourMsg && message != L10n.enterDetails
        case .password(let password):
            return password!.isValidPassword
        default:
            return true
        }
    }
    
    var errorMessage: (emptyMessage: String, invalidMessage: String) {
        switch self {
        case .name:
            return (L10n.nameEmpty, L10n.nameRequirements)
        case .email:
            return (L10n.emailEmpty, L10n.emailRequiremtnts)
        case .phone:
            return (L10n.phoneEmpty, L10n.phoneRequirements)
        case .message:
            return (L10n.dataRequirements, L10n.dataRequirements)
        case .password:
            return (L10n.passwordEmpty, L10n.passwordRequirements)
        case .confirmPassword:
            return (L10n.confirmPwEmpty, L10n.confirmPasswordAlert)
        }
    }
}
//MARK:- Enum
enum ValidationType {
    case name
    case email
    case phone
    case message
    case password
    
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
        guard let string = string?.trimmed, !string.isEmpty else { return false}
        
        switch validationType {
        case .email:
            if !string.isValidEmail {
                return false
            }
            return true
        case .password:
            if !string.isValidPassword {
                return false
            }
            return true
        case .name:
            if !string.isValidName {
                return false
            }
            return true
        case .phone:
            if !string.isValidPhone {
                return false
            }
            return true
        case .message:
            if string == L10n.enterDetails {
                return false
            }
            return true
        case .none:
            return true
        }
    }
    
    func isValidData(with validationType: ValidationError) -> String? {
        if !validationType.emptyField {
            return validationType.errorMessage.emptyMessage
        }
        
        if !validationType.validate {
            return validationType.errorMessage.invalidMessage
        }
        return nil
    }
}
