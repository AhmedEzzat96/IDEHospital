//
//  ValidationManager.swift
//  IDEHospital
//
//  Created by Ziad on 12/16/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

class ValidationManager {
    
    // MARK:- Singleton
    private static let sharedInstance = ValidationManager()
    
    class func shared() -> ValidationManager {
        return ValidationManager.sharedInstance
    }
}
