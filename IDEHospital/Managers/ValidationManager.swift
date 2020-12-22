//
//  ValidationManager.swift
//  IDEHospital
//
//  Created by Ziad on 12/17/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

/// name - email - phone - message
typealias RequestData = (String?, String?, String?, String?) // This typealias i will reuse it while implementing the Contact Us request

class ValidationManager {
    
    // MARK:- Enum
    enum ValidationError {
        case name, email, phone, missedData
        
        var error: (title: String, message: String) {
            switch self {
                case .name:
                    return (L10n.invalidName, L10n.nameRequirements)
            case .email:
                return (L10n.invalidEmail, L10n.emailRequiremtnts)
            case .phone:
                return (L10n.invalidPhoneNumber, L10n.phoneRequirements)
            case .missedData:
                return (L10n.missedData, L10n.dataRequirements)
            }
        }
    }
    
    // MARK:- Singleton
    private static let sharedInstance = ValidationManager()
    class func shared() -> ValidationManager {
        return ValidationManager.sharedInstance
    }
    
    // MARK:- Public Methods
    func tryToCathchErrors(with requestData: RequestData) -> (String, String)? {
        if let name = requestData.0?.trimmed, !name.isEmpty, let email = requestData.1?.trimmed, !email.isEmpty, let phone = requestData.2?.trimmed, !phone.isEmpty, let message = requestData.3, !message.isEmpty, message != L10n.enterDetails {
            
            switch isValidName(name) {
            case true: break
            case false:
                return ValidationError.name.error
            }
            
            switch isValidEmail(email) {
            case true: break
            case false:
                return ValidationError.email.error
            }
            
            switch isValidPhone(phone) {
            case true: break
            case false:
                return ValidationError.phone.error
            }
            
            return nil
        }
        return ValidationError.missedData.error
    }
}

// MARK:- Private Methods
extension ValidationManager {
    private func isValidName(_ name: String) -> Bool {
        guard name.count > 3, name.count < 18 else { return false }
        let regularExpressionForName = "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$"
        let testPassword = NSPredicate(format: "SELF MATCHES %@", regularExpressionForName)
        return testPassword.evaluate(with: name)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
        return testEmail.evaluate(with: email)
    }
    
    private func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = "^[0-9]{11}$"
        let testPassword = NSPredicate(format:"SELF MATCHES %@", phoneRegex)
        return testPassword.evaluate(with: phone)
    }
}
