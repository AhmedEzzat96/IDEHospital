//
//  SuccessOrFailurePopUpViewModel.swift
//  IDEHospital
//
//  Created by Ziad on 1/5/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import Foundation

protocol SuccessOrFailurePopUpViewModelProtocol {
    func getImageAndTitle() -> (String, String)
    func getOkButtonAction() -> String
}

class SuccessOrFailurePopUpViewModel {
    
    // MARK:- Properties
    private let popUpType: PopUpType
    private let okButtonAction: OkButtonAction
    
    // MARK:- Init
    init(popUpType: PopUpType, okButtonAction: OkButtonAction) {
        self.popUpType = popUpType
        self.okButtonAction = okButtonAction
    }
}

// MARK:- ViewModel Protocol
extension SuccessOrFailurePopUpViewModel: SuccessOrFailurePopUpViewModelProtocol {
    func getImageAndTitle() -> (String, String) {
        switch popUpType {
        case .success(let title):
            return (Asset.success.name, title)
        case .failure(let title):
            return (Asset.failure.name, title)
        }
    }
    
    func getOkButtonAction() -> String {
        return okButtonAction.rawValue
    }
}
