//
//  SignupResponse.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 27/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

struct AuthResponse: Codable {
    let data: AuthData?
    let code: Int
    let success: Bool?
    let errors: SignupErrors?
    let message: String?
}

struct SignupErrors: Codable {
    let email: [String]?
}

struct AuthData: Codable {
    let id: Int?
    let email: String?
    let name: String?
    let mobile: String?
    let access_token: String?
}
