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
                    if let emailError = response.errors?.email?[0] {
                        self.view?.showAlert(type: .failure(emailError), switchToHome: false)
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
            self.view?.showAlert(type: .failure(nameError), switchToHome: false)
            return false
        }
        
        if let emailError = ValidationManager.shared().isValidData(with: .email(user?.email)) {
            self.view?.showAlert(type: .failure(emailError), switchToHome: false)
            return false
        }
        
        if let mobileNoError = ValidationManager.shared().isValidData(with: .phone(user?.mobile)) {
            self.view?.showAlert(type: .failure(mobileNoError), switchToHome: false)
            return false
        }
        
        if let passwordError = ValidationManager.shared().isValidData(with: .password(user?.password)) {
            self.view?.showAlert(type: .failure(passwordError), switchToHome: false)
            return false
        }
        
        if let confirmPwError = ValidationManager.shared().isValidData(with: .confirmPassword(confirmPassword)) {
            self.view?.showAlert(type: .failure(confirmPwError), switchToHome: false)
            return false
        }
        
        if confirmPassword != user?.password {
            self.view?.showAlert(type: .failure(L10n.confirmPasswordAlert), switchToHome: false)
            return false
        }
        
        return true
    }
}
