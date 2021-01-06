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
    func getPlaceHolder() -> String
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
                if response.success, response.code == 202 {
                    self?.view?.showAlert(type: .success(L10n.yourRequestWasSent))
                }
            case .failure(let error):
                print(error)
                self?.view?.showAlert(type: .failure(L10n.responseError))
            }
            self?.view?.hideLoader()
        }
    }
    
    private func popOrDismiss() {
        switch status {
        case .homeNurse:
            view?.popUp()
        default:
            view?.dismiss()
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
    
    func getPlaceHolder() -> String {
        switch status {
        case .homeNurse:
            return L10n.enterDetails
        default:
            return L10n.yourMsg
        }
    }
    
    func textViewShouldEndEditing(text: String) {
        guard text.isEmpty else { return }
        switch status {
        case .homeNurse:
            view?.addPlaceholder(L10n.enterDetails)
        default:
            view?.addPlaceholder(L10n.yourMsg)
        }
    }
    
    func requestTapped(with requestData: RequestData) {
        
        if let nameError = ValidationManager.shared().isValidData(with: .name(requestData.name)) {
            self.view?.showAlert(type: .failure(nameError))
            return
        }
        
        if let emailError = ValidationManager.shared().isValidData(with: .email(requestData.email)) {
            self.view?.showAlert(type: .failure(emailError))
            return
        }
        
        if let phoneError = ValidationManager.shared().isValidData(with: .phone(requestData.mobile)) {
            self.view?.showAlert(type: .failure(phoneError))
            return
        }
        
        if let messageError = ValidationManager.shared().isValidData(with: .message(requestData.message)) {
            self.view?.showAlert(type: .failure(messageError))
            return
        } else {
            sendRequest(with: requestData)
        }
    }
}
