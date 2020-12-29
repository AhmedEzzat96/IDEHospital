//
//  HomeNurseViewModel.swift
//  IDEHospital
//
//  Created by Ziad on 12/16/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

protocol HomeNurseContactUsViewModelProtocol {
    func getTitles() -> (String, String)
    func isNumberLabelHidden() -> Bool
    func textViewShouldEndEditing(text: String)
    func requestTapped(with requestData: RequestData)
}

class HomeNurseContactUsViewModel {
    
    // MARK:- Properties
    private weak var view: HomeNurseContactUsVCProtocol?
    private var status: RequestType
    
    // MARK:- Init
    init(view: HomeNurseContactUsVCProtocol, status: RequestType) {
        self.view = view
        self.status = status
    }
}

// MARK:- Private Methods
extension HomeNurseContactUsViewModel {
    private func sendRequest(with requestData: RequestData) {
        let request: APIRouter
        switch status {
        case .homeNurse:
            request = APIRouter.nurseRequest(requestData)
        default:
            request = APIRouter.contactRequest(requestData)
        }
        view?.showLoader()
        APIManager.sendRequest(request) { [weak self] (response) in
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
extension HomeNurseContactUsViewModel: HomeNurseContactUsViewModelProtocol {
    func getTitles() -> (String, String) {
        switch status {
        case .homeNurse:
            return (viewTitle: L10n.homeNurse, buttonTitle: L10n.sendRequest)
        default:
            return (viewTitle: L10n.contactUs, buttonTitle: L10n.send)
        }
    }
    
    func isNumberLabelHidden() -> Bool {
        switch status {
        case .homeNurse:
            return true
        default:
            return false
        }
    }
    
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
            sendRequest(with: requestData)
        }
    }
}
