//
//  UserDefaultsManager.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 07/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation


class UserDefaultsManager {
    
    // MARK:- Singleton
    static let shared = UserDefaultsManager()
    private init() {}
    
    // MARK:- Properties
    var token: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.token)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.token) != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.token)!
        }
    }
    
    var id: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.id)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.id) != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.id)!
        }
    }
}

