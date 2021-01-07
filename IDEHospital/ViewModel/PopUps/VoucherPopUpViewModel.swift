//
//  VoucherPopUpViewModel.swift
//  IDEHospital
//
//  Created by Ziad on 1/5/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import Foundation

protocol VoucherPopUpViewModelProtocol {
    func continueTapped(_ isVoucherOn: Bool, _ isBookingForAnotherPerson: Bool)
}

class VoucherPopUpViewModel {
    
    // MARK:- Properties
    private weak var view: VoucherPopUpVCProtocol?
    private var appointment: Appointment!
    private var doctorName: String
    
    // MARK:- Init
    init(view: VoucherPopUpVCProtocol, appointment: Appointment, doctorName: String) {
        self.view = view
        self.appointment = appointment
        self.doctorName = doctorName
    }
}

// MARK:- Private Methods
extension VoucherPopUpViewModel {
    private func isValidVoucherAndPatient(_ isVoucherOn: Bool, _ isBookingForAnotherPerson: Bool) -> Bool {
        switch (isVoucherOn, isBookingForAnotherPerson) {
        case (false, false):
            appointment.isBookingForAnotherPerson = 0
            return true
        case (true, true):
            guard isValidVoucher(), isValidPatientName() else { return false }
            return true
        case (true, false):
            appointment.isBookingForAnotherPerson = 0
            return isValidVoucher()
        case (false, true):
            return isValidPatientName()
        }
    }
    
    private func isValidVoucher() -> Bool {
        if let voucherError = ValidationManager.shared().isValidData(with: .voucher(view?.getVoucherCode())) {
            view?.showAlert(type: .failure(voucherError))
            return false
        } else {
            appointment.voucher = view?.getVoucherCode()
            return true
        }
    }
    
    private func isValidPatientName() -> Bool {
        if let nameError = ValidationManager.shared().isValidData(with: .name(view?.getPatientName())) {
            view?.showAlert(type: .failure(nameError))
            appointment.isBookingForAnotherPerson = 0
            return false
        } else {
            appointment.patientName = view?.getPatientName()
            appointment.isBookingForAnotherPerson = 1
            return true
        }
    }
}

// MARK:- ViewModel Protocol
extension VoucherPopUpViewModel: VoucherPopUpViewModelProtocol {
    func continueTapped(_ isVoucherOn: Bool, _ isBookingForAnotherPerson: Bool) {
        if isValidVoucherAndPatient(isVoucherOn, isBookingForAnotherPerson) {
            view?.askForConfirmation(for: appointment, doctorName: doctorName)
        }
    }
}
