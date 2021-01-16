//
//  AuthAndBook.swift
//  IDEHospital
//
//  Created by Ziad on 1/16/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import Foundation

struct UserAndBooking: Codable {
    // auth
    var email: String?
    var password: String?
    var mobile: String?
    var name: String?
    
    // booking
    let doctorID: Int
    var doctorName: String?
    let timestamp: String
    var patientName: String?
    var voucher: String?
    
    init(email: String? = nil, password: String? = nil, mobile: String? = nil, name: String? = nil, doctorID: Int, doctorName: String?, timestamp: String, patientName: String? = nil, voucher: String? = nil) {
        self.email = email
        self.password = password
        self.mobile = mobile
        self.name = name
        self.doctorID = doctorID
        self.doctorName = doctorName
        self.timestamp = timestamp
        self.patientName = patientName
        self.voucher = voucher
    }
    
    enum CodingKeys: String, CodingKey {
        case email, password, mobile, name
        case doctorID = "doctor_id"
        case timestamp = "appointment"
        case patientName = "patient_name"
        case voucher
    }
}
