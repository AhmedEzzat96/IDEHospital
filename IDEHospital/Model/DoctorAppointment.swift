//
//  DoctorAppointment.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 05/01/2021.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import Foundation

struct DoctorAppointment: Codable {
    let code: Int
    let success: Bool?
    let data: [DoctorAppointmentData]?
}

struct DoctorAppointmentData: Codable {
    let date: Int
    let times: [DoctorAppointmentTime]
}

struct DoctorAppointmentTime: Codable {
    let time: Int
    let booked: Bool
}

