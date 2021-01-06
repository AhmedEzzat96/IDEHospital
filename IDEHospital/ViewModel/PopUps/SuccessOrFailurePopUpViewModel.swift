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
    func getOkButtonTarget() -> String
}

class SuccessOrFailurePopUpViewModel {
    
    // MARK:- Properties
    private weak var view: SuccessOrFailurePopUpVCProtocol?
    private let popUpType: PopUpType
    private let switchToHome: Bool
    
    // MARK:- Init
    init(view: SuccessOrFailurePopUpVCProtocol, popUpType: PopUpType, switchToHome: Bool) {
        self.view = view
        self.popUpType = popUpType
        self.switchToHome = switchToHome
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
    
    func getOkButtonTarget() -> String {
        if switchToHome {
            return "switchToHome"
        } else {
            return "dismissCurrent"
        }
    }
}
