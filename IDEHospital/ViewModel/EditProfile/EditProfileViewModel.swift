//
//  EditProfileViewModel.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 14/01/2021.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import Foundation

protocol EditProfileViewModelProtocol {
    func getUserData()
    func editUserData(name: String?, email: String?, mobileNo: String?, oldPassword: String?, newPassword: String?, confirmPassword: String?)
}

class EditProfileViewModel {
    // MARK:- Properties
    private weak var view: EditProfileVCProtocol?
    
    // MARK:- Init
    init(view: EditProfileVCProtocol?) {
        self.view = view
    }
}

// MARK:- Private Methods
extension EditProfileViewModel {
    private func validateUser(name: String?, email: String?, mobileNo: String?, oldPassword: String?, newPassword: String?, confirmPassword: String?) -> Bool {
        if let nameError = ValidationManager.shared().isValidData(with: .name(name)) {
            self.view?.showAlert(.failure(nameError), okButtonAction: .dismissCurrent)
            return false
        }
        
        if let emailError = ValidationManager.shared().isValidData(with: .email(email)) {
            self.view?.showAlert(.failure(emailError), okButtonAction: .dismissCurrent)
            return false
        }
        
        if let mobileNoError = ValidationManager.shared().isValidData(with: .phone(mobileNo)) {
            self.view?.showAlert(.failure(mobileNoError), okButtonAction: .dismissCurrent)
            return false
        }
        
        guard let oldPassword = oldPassword,
              let newPassword = newPassword,
              let confirmPassword = confirmPassword else { return false }
        
        if !oldPassword.isEmpty || !newPassword.isEmpty || !confirmPassword.isEmpty {
            if let oldPasswordError = ValidationManager.shared().isValidData(with: .oldPassword(oldPassword)) {
                self.view?.showAlert(.failure(oldPasswordError), okButtonAction: .dismissCurrent)
                return false
            }
            
            if let newPasswordError = ValidationManager.shared().isValidData(with: .newPassword(newPassword)) {
                self.view?.showAlert(.failure(newPasswordError), okButtonAction: .dismissCurrent)
                return false
            }
            
            if let confirmPwError = ValidationManager.shared().isValidData(with: .confirmPassword(confirmPassword)) {
                self.view?.showAlert(.failure(confirmPwError), okButtonAction: .dismissCurrent)
                return false
            }
            
            if confirmPassword != newPassword {
                self.view?.showAlert(.failure(L10n.confirmPasswordAlert), okButtonAction: .dismissCurrent)
                return false
            }
        }
        
        return true
    }
    
    private func editProfile(with user: User) {
        self.view?.showLoader()
        APIManager.editProfile(with: user) { [weak self] (result) in
            switch result {
            case .success(let response):
                if response.code == 200 && response.success == true {
                    self?.view?.showAlert(.success(L10n.editProfileMessage), okButtonAction: .delegation)
                } else {
                    if let emailError = response.errors?.email {
                        self?.view?.showAlert(.failure(emailError[0]), okButtonAction: .dismissCurrent)
                    }
                    if let passwordError = response.message {
                        self?.view?.showAlert(.failure(passwordError), okButtonAction: .dismissCurrent)
                    }
                }
            case .failure(let error):
                print(error)
            }
            self?.view?.hideLoader()
        }
    }
}

// MARK:- EditProfile ViewModel Protocol
extension EditProfileViewModel: EditProfileViewModelProtocol {
    func getUserData() {
        self.view?.showLoader()
        APIManager.getUserData { [weak self] (result) in
            switch result {
            case .success(let response):
                if response.code == 200 && response.success == true {
                    guard let userData = response.data else { return }
                    DispatchQueue.main.async {
                        self?.view?.showUserData(with: userData)
                    }
                }
            case .failure(let error):
                print(error)
            }
            self?.view?.hideLoader()
        }
    }
    
    func editUserData(name: String?, email: String?, mobileNo: String?, oldPassword: String?, newPassword: String?, confirmPassword: String?) {
        var user: User!
        if validateUser(name: name, email: email, mobileNo: mobileNo, oldPassword: oldPassword, newPassword: newPassword, confirmPassword: confirmPassword) {
            if oldPassword == "" {
                user = User(name: name, email: email, mobile: mobileNo)
            } else {
                user = User(name: name, email: email, mobile: mobileNo, password: newPassword, oldPassword: oldPassword)
            }
            editProfile(with: user)
        }
    }
}
