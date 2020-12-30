//
//  MyAppointmentResponse.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 21/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

struct MyAppointmentResponse: Codable {
    let code: Int
    let data: MyAppointmentData?
    let success: Bool?
    let message: String?
    let errors: String?
}

struct MyAppointmentData: Codable {
    let items: [MyAppointmentItem]?
    let page: Int?
    let total_pages: Int?
    let total: Int?
}

struct MyAppointmentItem: Codable {
    let id: Int
    let appointment: Int
    let patient_name: String
    let doctor: DoctorItem
}

struct DoctorItem: Codable {
    let id: Int
    let name: String
    let rating: Int
    let reviews_count: Int
    let bio: String
    let lng: Double
    let lat: Double
    let image: String
    let address: String
}
