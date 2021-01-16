//
//  ValidationManager.swift
//  IDEHospital
//
//  Created by Ziad on 12/17/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

//MARK:- Enum
enum ValidationError {
    case name(_ name: String?)
    case email(_ email: String?)
    case phone(_ phone: String?)
    case message(_ message: String?)
    case oldPassword(_ oldPassword: String?)
    case password(_ password: String?)
    case newPassword(_ newPassword: String?)
    case confirmPassword(_ confirmPassword: String?)
    case reviewComment(_ reviewComment: String?)
    case voucher(_ voucher: String?)
    
    var emptyField: Bool {
        switch self {
        case .name(let text), .email(let text), .password(let text), .message(let text), .phone(let text), .confirmPassword(let text), .reviewComment(let text), .voucher(let text), .oldPassword(let text), .newPassword(let text):
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
        case .password(let password), .oldPassword(let password), .newPassword(let password):
            return password!.isValidPassword
        case .reviewComment(let text), .voucher(let text):
            return text!.trimmed.count >= 3
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
        case .oldPassword:
            return (L10n.oldPasswordEmpty, L10n.oldPasswordRequirements)
        case .newPassword:
            return (L10n.newPasswordEmpty, L10n.newPasswordRequirements)
        case .password:
            return (L10n.passwordEmpty, L10n.passwordRequirements)
        case .confirmPassword:
            return (L10n.confirmPwEmpty, L10n.confirmPasswordAlert)
        case .reviewComment:
            return (L10n.emptyComment, L10n.commentRequirements)
        case .voucher:
            return (L10n.emptyVoucher, L10n.voucherRequirements)
        }
    }
}

class ValidationManager {
    
    // MARK:- Singleton
    private static let sharedInstance = ValidationManager()
    
    //MARK:- Public Methods
    class func shared() -> ValidationManager {
        return ValidationManager.sharedInstance
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
