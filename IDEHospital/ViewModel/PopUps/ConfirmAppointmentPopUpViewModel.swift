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
    func confirmTapped()
}

class ConfirmAppointmentPopUpViewModel {
    
    // MARK:- Properties
    private weak var view: ConfirmAppointmentPopUpVCProtocol?
    private let appointment: Appointment!
    private let doctorName: String
    
    // MARK:- Init
    init(view: ConfirmAppointmentPopUpVCProtocol, appointment: Appointment, doctorName: String) {
        self.view = view
        self.appointment = appointment
        self.doctorName = doctorName
    }
}
// MARK:- Private Methods
extension ConfirmAppointmentPopUpViewModel {
    // Next To functions will be reused later
    private func createTime(timestamp: Int) -> String {
        var strDate = ""
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
        dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = L10n.timeFormat //Specify your format that you want
        dateFormatter.amSymbol = L10n.am
        dateFormatter.pmSymbol = L10n.pm
        strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    private func createDate(timestamp: Int) -> String {
        var strDate = ""
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
        dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = L10n.dateFormat //Specify your format that you want
        strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    private func checkSuccessResponse(_ response: AppointmentResponse) {
        if response.success == true, response.code == 202 {
            view?.showAlert(type: .success(L10n.successfullyBooked))
        } else if let responseMessage = response.message {
            view?.showAlert(type: .failure(responseMessage))
        } else if let voucherError = response.errors?.voucher?[0] {
            view?.showAlert(type: .failure(voucherError))
        } else if let appointmentError = response.errors?.appointment?[0] {
            view?.showAlert(type: .failure(appointmentError))
        }
    }
}

// MARK:- ViewModel Protocol
extension ConfirmAppointmentPopUpViewModel: ConfirmAppointmentPopUpViewModelProtocol {
    func getDoctorName() -> String {
        return doctorName
    }
    
    func getDateAndTime() -> String {
        print(createDate(timestamp: appointment.timestamp) + createTime(timestamp: appointment.timestamp))
        return "\(createDate(timestamp: appointment.timestamp)) \(createTime(timestamp: appointment.timestamp))"
    }
    func confirmTapped() {
        guard UserDefaultsManager.shared().token != nil else {
            view?.showAlert(type: .failure("Must be Authenticated"))
            return
        }
        APIManager.bookAppointment(appointment) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.checkSuccessResponse(response)
            case .failure(let error):
                print(error)
                self?.view?.showAlert(type: .failure(L10n.responseError))
            }
        }
    }
}
