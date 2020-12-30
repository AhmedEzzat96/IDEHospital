//
//  SignupViewModel.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 27/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

protocol SignupViewModelProtocol {
    func goToHome(user: User?, confirmPassword: String?)
}

class SignupViewModel {
    //MARK:- Properties
    private weak var view: AuthProtocol?
    
    //MARK:- Init
    init(view: AuthProtocol) {
        self.view = view
    }
}

//MARK:- SignupViewModel Protocol
extension SignupViewModel: SignupViewModelProtocol {
    func goToHome(user: User?, confirmPassword: String?) {
        if validateUser(with: user, confirmPassword: confirmPassword) {
            register(with: user!)
        }
    }
}

//MARK:- Private Methods
extension SignupViewModel {
    private func register(with user: User) {
        self.view?.showLoader()
        APIManager.register(with: user) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
                
            case .success(let response):
                if response.code == 201 && response.success == true {
                    UserDefaultsManager.shared().token = response.data?.access_token
                    self.view?.goToHomeScreen()
                } else {
                    if let email = response.errors?.email?[0] {
                        self.view?.showAlert(title: L10n.warning, message: email, handler: nil)
                    }
                }
            case .failure(let error):
                print(error)
            }
            self.view?.hideLoader()
        }
    }
    
    private func validateUser(with user: User?, confirmPassword: String?) -> Bool {
        if let nameError = ValidationManager.shared().isValidData(with: .name(user?.name)) {
            self.view?.showAlert(title: L10n.sorry, message: nameError, handler: nil)
            return false
        }
        
        if let emailError = ValidationManager.shared().isValidData(with: .email(user?.email)) {
            self.view?.showAlert(title: L10n.sorry, message: emailError, handler: nil)
            return false
        }
        
        if let mobileNoError = ValidationManager.shared().isValidData(with: .phone(user?.mobile)) {
            self.view?.showAlert(title: L10n.sorry, message: mobileNoError, handler: nil)
            return false
        }
        
        if let passwordError = ValidationManager.shared().isValidData(with: .password(user?.password)) {
            self.view?.showAlert(title: L10n.sorry, message: passwordError, handler: nil)
            return false
        }
        
        if let confirmPwError = ValidationManager.shared().isValidData(with: .confirmPassword(confirmPassword)) {
            self.view?.showAlert(title: L10n.sorry, message: confirmPwError, handler: nil)
            return false
        }
        
        if confirmPassword != user?.password {
            self.view?.showAlert(title: L10n.sorry, message: L10n.confirmPasswordAlert, handler: nil)
            return false
        }
        
        return true
    }
}
