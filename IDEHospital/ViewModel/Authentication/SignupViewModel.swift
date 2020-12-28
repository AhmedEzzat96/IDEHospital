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
    private weak var view: SignupVCProtocol?
    
    //MARK:- Init
    init(view: SignupVCProtocol) {
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
                        self.view?.showAlert(title: L10n.warning, message: email)
                    }
                }
            case .failure(let error):
                print(error)
            }
            self.view?.hideLoader()
        }
    }
    
    private func validateUser(with user: User?, confirmPassword: String?) -> Bool {
        if !ValidationManager.shared().isValid(with: user?.name, validationType: .name) {
            self.view?.showAlert(title: ValidationType.name.error.title, message: ValidationType.name.error.message)
            return false
        }
        
        if !ValidationManager.shared().isValid(with: user?.email, validationType: .email) {
            self.view?.showAlert(title: ValidationType.email.error.title, message: ValidationType.email.error.message)
            return false
        }
        
        if !ValidationManager.shared().isValid(with: user?.mobile, validationType: .phone) {
            self.view?.showAlert(title: ValidationType.phone.error.title, message: ValidationType.phone.error.message)
            return false
        }
        
        if !ValidationManager.shared().isValid(with: user?.password, validationType: .password) {
            self.view?.showAlert(title: ValidationType.password.error.title, message: ValidationType.password.error.message)
            return false
        }
        
        if confirmPassword != user?.password {
            self.view?.showAlert(title: L10n.incorrectPassword, message: L10n.confirmPasswordAlert)
            return false
        }
        
        return true
    }
}
