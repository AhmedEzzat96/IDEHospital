//
//  RequestData.swift
//  IDEHospital
//
//  Created by Ziad on 12/22/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

struct RequestData: Codable {
    let name: String?
    let email: String?
    let mobile: String?
    let message: String?
}

struct NurseResponse: Codable {
    let code: Int
    let success: Bool
}
