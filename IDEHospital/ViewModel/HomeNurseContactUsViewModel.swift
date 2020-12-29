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

class HomeNurseViewModel {
    
    // MARK:- Properties
    private weak var view: HomeNurseContactUsVCProtocol?
    private var status: RequestStatus
    
    // MARK:- Init
    init(view: HomeNurseContactUsVCProtocol, status: RequestStatus) {
        self.view = view
        self.status = status
    }
}

// MARK:- Private Methods
extension HomeNurseViewModel {
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
extension HomeNurseViewModel: HomeNurseContactUsViewModelProtocol {
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
        if let validationError = ValidationManager.shared().tryToCathchErrors(with: requestData) {
            view?.showAlert(title: validationError.0, message: validationError.1, handler: nil)
        } else {
            sendRequest(with: requestData)
        }
    }
}
