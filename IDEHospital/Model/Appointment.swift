//
//  Appointment.swift
//  IDEHospital
//
//  Created by Ziad on 1/5/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import Foundation

struct Appointment: Codable {
    var doctorID: Int
    var timestamp: Int?
    var isBookingForAnotherPerson: Int?
    var patientName: String?
    var voucher: String?
    
    enum CodingKeys: String, CodingKey {
        case doctorID = "doctor_id"
        case timestamp = "appointment"
        case patientName = "patient_name"
        case isBookingForAnotherPerson = "book_for_another"
        case voucher
    }
}

struct AppointmentResponse: Codable {
    let code: Int
    let success: Bool?
    let message: String?
    let errors: AppointmentError?
}

struct AppointmentError: Codable {
    let voucher: [String]?
    let appointment: [String]?
}
