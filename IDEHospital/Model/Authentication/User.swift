//
//  User.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 27/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

struct User: Codable {
    let name: String?
    let email: String?
    let mobile: String?
    let password: String?
    
    init(name: String? = nil, email: String?, mobile: String? = nil, password: String?) {
        self.name = name
        self.email = email
        self.mobile = mobile
        self.password = password
    }
}
