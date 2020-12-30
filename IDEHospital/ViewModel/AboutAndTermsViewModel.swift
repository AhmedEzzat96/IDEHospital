//
//  AboutAndTermsViewModel.swift
//  IDEHospital
//
//  Created by Ziad on 12/29/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

protocol AboutAndTermsViewModelProtocol {
    func getTitle() -> String
    func getAboutOrTerms()
}

class AboutAndTermsViewModel {
    
    // MARK:- Properties
    private weak var view: AboutAndTermsVCProtocol?
    private let status: InfoType!
    
    // MARK:- Init
    init(view: AboutAndTermsVCProtocol, status: InfoType) {
        self.view = view
        self.status = status
    }
}

// MARK:- Private Methods
extension AboutAndTermsViewModel {
    private func getAboutOrTerms(_ request: APIRouter) {
        view?.showLoader()
        APIManager.getAboutOrTerms(request) { [weak self] (result) in
            switch result {
            case .success(let response):
                if let text = self?.getStatusText(from: response), response.success, response.code == 200 {
                    self?.view?.displayText(text)
                }
            case .failure(let error):
                self?.view?.showAlert(title: L10n.sorry, message: error.localizedDescription)
            }
            self?.view?.hideLoader()
        }
    }
    
    private func getStatusText(from response: AboutAndTermsResponse) -> String? {
        switch status {
        case .aboutUs:
            return response.data?.aboutUs?.htmlToString
        default:
            return response.data?.terms?.htmlToString
        }
    }
}

// MARK:- ViewModel Protocol
extension AboutAndTermsViewModel: AboutAndTermsViewModelProtocol {
    func getTitle() -> String {
        switch status {
        case .aboutUs:
            return L10n.about
        default:
            return L10n.termsAndConditions
        }
    }
    
    func getAboutOrTerms() {
        let request: APIRouter
        switch status {
        case .aboutUs:
            request = APIRouter.aboutUs
            getAboutOrTerms(request)
        default:
            request = APIRouter.terms
            getAboutOrTerms(request)
        }
    }
}
