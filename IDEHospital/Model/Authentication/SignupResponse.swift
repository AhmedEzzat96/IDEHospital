//
//  SignupResponse.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 27/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

struct SignupResponse: Codable {
    let data: SignupData?
    let code: Int
    let success: Bool?
    let errors: SignupErrors?
}

struct SignupErrors: Codable {
    let email: [String]?
}

struct SignupData: Codable {
    let id: Int?
    let email: String?
    let name: String?
    let mobile: String?
    let access_token: String?
}
