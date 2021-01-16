//
//  UnAuthenticatedPopUpViewModel.swift
//  IDEHospital
//
//  Created by Ziad on 1/15/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import Foundation

enum DisplayedView {
    case register
    case login
}

protocol UnAuthenticatedPopUpViewModelProtocol {
    func configureDisplayedView(_ displayedView: DisplayedView)
    func authAndBookTapped()
}

class UnAuthenticatedPopUpViewModel {
    
    // MARK:- Properties
    private weak var view: UnAuthenticatedPopUpVCProtocol?
    private var userAndBooking: UserAndBooking!
    private var displayedView: DisplayedView! {
        willSet {
            userAndBooking = UserAndBooking(doctorID: userAndBooking.doctorID, doctorName: userAndBooking.doctorName, timestamp: userAndBooking.timestamp)
        }
    }
    
    // MARK:- Init
    init(view: UnAuthenticatedPopUpVCProtocol, displayedView: DisplayedView, userAndBooking: UserAndBooking) {
        self.view = view
        self.userAndBooking = userAndBooking
        self.displayedView = displayedView
    }
}

// MARK:- Private Methods
extension UnAuthenticatedPopUpViewModel {
    private func handleRegisteration() {
        guard let registerationFields = view?.getRegisterationData() else { return }
        if isValidRegisterationData(registerationFields: registerationFields) {
            configureUserData(with: registerationFields)
            configureVoucherAndPatientName(with: registerationFields)
            view?.askForConfirmation(for: Int(userAndBooking.timestamp)!, doctorName: userAndBooking.doctorName!, delegate: self)
        }
    }
    
    private func handleLogin() {
        guard let loginFields = view?.getLoginData() else { return }
        if isValidLoginData(loginFields: loginFields) {
            configureUserData(with: loginFields)
            configureVoucherAndPatientName(with: loginFields)
            view?.askForConfirmation(for: Int(userAndBooking.timestamp)!, doctorName: userAndBooking.doctorName!, delegate: self)
        }
    }
    
    private func isValidRegisterationData(registerationFields: AuthFields) -> Bool {
        if let nameError = checkForError(.name(registerationFields.name)) {
            view?.showAlert(.failure(nameError))
            return false
        }
        if let emailError = checkForError(.email(registerationFields.email)) {
            view?.showAlert(.failure(emailError))
            return false
        }
        if let mobileError = checkForError(.phone(registerationFields.mobile)) {
            view?.showAlert(.failure(mobileError))
            return false
        }
        if let passwordError = checkForError(.password(registerationFields.password)) {
            view?.showAlert(.failure(passwordError))
            return false
        }
        if registerationFields.isVoucherEnabled, let voucherError = checkForError(.voucher(registerationFields.voucher)) {
            view?.showAlert(.failure(voucherError))
            return false
        }
        if registerationFields.isBookingForAnotherEnabled, let patientNameError = checkForError(.name(registerationFields.patientName)) {
            view?.showAlert(.failure(patientNameError))
            return false
        }
        return true
    }
    
    private func isValidLoginData(loginFields: AuthFields) -> Bool {
        if let emailError = checkForError(.email(loginFields.email)) {
            view?.showAlert(.failure(emailError))
            return false
        }
        if let passwordError = checkForError(.password(loginFields.password)) {
            view?.showAlert(.failure(passwordError))
            return false
        }
        if loginFields.isVoucherEnabled, let voucherError = checkForError(.voucher(loginFields.voucher)) {
            view?.showAlert(.failure(voucherError))
            return false
        }
        if loginFields.isBookingForAnotherEnabled, let patientNameError = checkForError(.name(loginFields.patientName)) {
            view?.showAlert(.failure(patientNameError))
            return false
        }
        return true
    }
    
    private func checkForError(_ validationError: ValidationError) -> String? {
        if let error = ValidationManager.shared().isValidData(with: validationError) {
            return error
        }
        return nil
    }
    
    private func configureUserData(with authFields: AuthFields) {
        self.userAndBooking.email = authFields.email
        self.userAndBooking.password = authFields.password
        if displayedView == .register {
            self.userAndBooking.name = authFields.name
            self.userAndBooking.mobile = authFields.mobile
        }
    }
    
    private func configureVoucherAndPatientName(with authFields: AuthFields) {
        if authFields.isVoucherEnabled {
            self.userAndBooking.voucher = authFields.voucher
        } else {
            self.userAndBooking.voucher = nil
        }
        if authFields.isBookingForAnotherEnabled {
            self.userAndBooking.patientName = authFields.patientName
        } else {
            self.userAndBooking.patientName = nil
        }
    }
    
    private func authAndBook(_ request: APIRouter) {
        APIManager.authAndBook(request) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.checkAuthAndBookResponse(response)
            case .failure(let error):
                print(error)
                self?.view?.showAlert(.failure(L10n.responseError))
            }
        }
    }
    
    private func checkAuthAndBookResponse(_ response: AuthResponse) {
        if response.success == true, response.code == 201 {
            UserDefaultsManager.shared().token = response.data?.access_token
            view?.showSuccessfullyBookedAlert(message: getSuccessMessage())
        } else if let responseMessage = response.message {
            view?.showAlert(.failure(responseMessage))
        } else if let emailError = response.errors?.email?[0] {
            view?.showAlert(.failure(emailError))
        } else if let voucherError = response.errors?.voucher?[0] {
            view?.showAlert(.failure(voucherError))
        }
    }
    
    private func getSuccessMessage() -> String {
        switch displayedView {
        case .register:
            return L10n.accCreatedSuccessfullyBooked
        default:
            return L10n.loggedSuccessfullyBooked
        }
    }
}

// MARK:- ViewModel Protocol
extension UnAuthenticatedPopUpViewModel: UnAuthenticatedPopUpViewModelProtocol {
    func configureDisplayedView(_ displayedView: DisplayedView) {
        self.displayedView = displayedView
    }
    
    func authAndBookTapped() {
        switch displayedView {
        case .register:
            handleRegisteration()
        default:
            handleLogin()
        }
    }
}

// MARK:- ConfirmationPopUp Delegate
extension UnAuthenticatedPopUpViewModel: DoctorProfilePopupsDelegate {
    func confirmTapped() {
        switch displayedView {
        case .register:
            authAndBook(APIRouter.registerAndBook(userAndBooking))
        default:
            authAndBook(APIRouter.loginAndBook(userAndBooking))
        }
    }
}

