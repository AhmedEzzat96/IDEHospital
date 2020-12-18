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
            case .success:
                self?.view?.showAlert(title: "Done", message: "Your request was sent") { (action) in
                    self?.view?.showHomeVC()
                }
            case .failure(let error):
                self?.view?.showAlert(title: L10n.sorry, message: error.localizedDescription, handler: nil)
            }
            self?.view?.hideLoader()
        }
    }
}

extension HomeNurseViewModel: HomeNurseViewModelProtocol {
    func textViewShouldEndEditing(text: String) {
        if text.isEmpty {
            view?.addPlaceholder()
        }
    }
    
    func requestTapped(with requestData: RequestData) {
        if let validationError = ValidationManager.shared().tryToCathchErrors(with: requestData) {
            view?.showAlert(title: validationError.0, message: validationError.1, handler: nil)
        } else {
            sendNurseRequest(with: requestData)
        }
    }
}
