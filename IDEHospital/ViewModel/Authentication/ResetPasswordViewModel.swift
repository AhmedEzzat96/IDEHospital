//
//  ResetPasswordViewModel.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 28/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

protocol ResetPasswordViewModelProtocol {
    func goToHome(user: User?)
}

class ResetPasswordViewModel {
    //MARK:- Properties
    private weak var view: AuthProtocol?
    
    //MARK:- Init
    init(view: AuthProtocol) {
        self.view = view
    }
}

//MARK:- ResetPasswordViewModel Protocol
extension ResetPasswordViewModel: ResetPasswordViewModelProtocol {
    func goToHome(user: User?) {
        if validateEmail(with: user) {
            resetPassword(with: user!)
        }
    }
    
}

//MARK:- Private Methods
extension ResetPasswordViewModel {
    private func resetPassword(with user: User) {
        self.view?.showLoader()
        APIManager.forgetPassword(with: user) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
                
            case .success(let response):
                if response.code == 202 && response.success == true {
                    self.view?.showAlert(title: L10n.yourRequestWasSent, message: L10n.resetPasswordMsg, handler: { [weak self] (alert) in
                        
                        DispatchQueue.main.async {
                            self?.view?.goToHomeScreen()
                        }
                        
                    })
                } else {
                    if let error = response.errors?.email?[0] {
                        self.view?.showAlert(title: L10n.warning, message: error, handler: nil)
                    }
                }
            case .failure(let error):
                print(error)
            }
            self.view?.hideLoader()
        }
    }
    
    private func validateEmail(with user: User?) -> Bool {
        if let emailError = ValidationManager.shared().isValidData(with: .email(user?.email)) {
            self.view?.showAlert(title: L10n.sorry, message: emailError, handler: nil)
            return false
        }
        return true
    }
}
