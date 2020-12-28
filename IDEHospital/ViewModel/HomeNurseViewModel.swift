//
//  HomeNurseViewModel.swift
//  IDEHospital
//
//  Created by Ziad on 12/16/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

protocol HomeNurseViewModelProtocol {
    func textViewShouldEndEditing(text: String)
    func requestTapped(with requestData: RequestData)
}

class HomeNurseViewModel {
    
    // MARK:- Properties
    private weak var view: HomeNurseVCProtocol?
    
    // MARK:- Init
    init(view: HomeNurseVCProtocol) {
        self.view = view
    }
}

// MARK:- Private Methods
extension HomeNurseViewModel {    
    private func sendNurseRequest(with requestData: RequestData) {
        view?.showLoader()
        APIManager.sendNurseRequest(requestData) { [weak self] (response) in
            switch response {
            case .success(let response):
                print(response.code)
                if response.success, response.code == 202 {
                    self?.view?.showAlert(title: L10n.done, message: L10n.yourRequestWasSent) { (action) in
                        self?.view?.showHomeVC()
                    }
                }
            case .failure(let error):
                print(error)
                self?.view?.showAlert(title: L10n.sorry, message: error.localizedDescription, handler: nil)
            }
            self?.view?.hideLoader()
        }
    }
}

// MARK:- ViewModel Protocol
extension HomeNurseViewModel: HomeNurseViewModelProtocol {
    func textViewShouldEndEditing(text: String) {
        if text.isEmpty {
            view?.addPlaceholder()
        }
    }
    
    func requestTapped(with requestData: RequestData) {
        if !ValidationManager.shared().isValid(with: requestData.name, validationType: .name) {
            view?.showAlert(title: ValidationType.name.error.title, message: ValidationType.name.error.message, handler: nil)
        }
        
        if !ValidationManager.shared().isValid(with: requestData.email, validationType: .email) {
            view?.showAlert(title: ValidationType.email.error.title, message: ValidationType.email.error.message, handler: nil)
        }
        
        if !ValidationManager.shared().isValid(with: requestData.mobile, validationType: .phone) {
            view?.showAlert(title: ValidationType.phone.error.title, message: ValidationType.phone.error.message, handler: nil)
        }
        
        if !ValidationManager.shared().isValid(with: requestData.message, validationType: .message) {
            view?.showAlert(title: ValidationType.message.error.title, message: ValidationType.message.error.message, handler: nil)
        } else {
            sendNurseRequest(with: requestData)
        }
    }
}
