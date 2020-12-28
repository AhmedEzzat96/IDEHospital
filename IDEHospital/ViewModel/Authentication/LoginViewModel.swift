//
//  LoginViewModel.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 28/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

protocol LoginViewModelProtocol {
    func goToHome(user: User?)
}

class LoginViewModel {
    //MARK:- Properties
    private weak var view: AuthProtocol?
    
    //MARK:- Init
    init(view: AuthProtocol) {
        self.view = view
    }
}

//MARK:- LoginViewModel Protocol
extension LoginViewModel: LoginViewModelProtocol {
    func goToHome(user: User?) {
        if validateUser(with: user) {
            register(with: user!)
        }
    }
    
}

//MARK:- Private Methods
extension LoginViewModel {
    private func register(with user: User) {
        self.view?.showLoader()
        APIManager.login(with: user) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
                
            case .success(let response):
                if response.code == 201 && response.success == true {
                    UserDefaultsManager.shared().token = response.data?.access_token
                    self.view?.goToHomeScreen()
                } else {
                    if let message = response.message {
                        self.view?.showAlert(title: L10n.warning, message: message)
                    }
                }
            case .failure(let error):
                print(error)
            }
            self.view?.hideLoader()
        }
    }
    
    private func validateUser(with user: User?) -> Bool {
        
        if !ValidationManager.shared().isValid(with: user?.email, validationType: .email) {
            self.view?.showAlert(title: ValidationType.email.error.title, message: ValidationType.email.error.message)
            return false
        }
        
        if !ValidationManager.shared().isValid(with: user?.password, validationType: .password) {
            self.view?.showAlert(title: ValidationType.password.error.title, message: ValidationType.password.error.message)
            return false
        }
        
        return true
    }
}
