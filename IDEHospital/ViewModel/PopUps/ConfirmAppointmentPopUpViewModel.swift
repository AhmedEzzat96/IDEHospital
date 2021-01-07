//
//  ConfirmAppointmentPopUpViewModel.swift
//  IDEHospital
//
//  Created by Ziad on 1/5/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import Foundation

protocol ConfirmAppointmentPopUpViewModelProtocol {
    func getDoctorName() -> String
    func getDateAndTime() -> String
}

class ConfirmAppointmentPopUpViewModel {
    
    // MARK:- Properties
    private let appointment: Appointment!
    private let doctorName: String
    
    // MARK:- Init
    init(appointment: Appointment, doctorName: String) {
        self.appointment = appointment
        self.doctorName = doctorName
    }
}

// MARK:- ViewModel Protocol
extension ConfirmAppointmentPopUpViewModel: ConfirmAppointmentPopUpViewModelProtocol {
    func getDoctorName() -> String {
        return doctorName
    }
    
    func getDateAndTime() -> String {
        return "\(appointment.timestamp!.createDate()) \(appointment.timestamp!.createTime())"
    }
}
