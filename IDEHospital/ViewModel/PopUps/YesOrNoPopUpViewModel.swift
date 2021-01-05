//
//  YesOrNoPopUpViewModel.swift
//  IDEHospital
//
//  Created by Ziad on 1/5/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import Foundation

protocol YesOrNoPopUpViewModelProtocol {
    func getTitle() -> String
}

class YesOrNoPopUpViewModel {
    
    // MARK:- Properties
    private weak var view: YesOrNoPopUpVCProtocol?
    private let title: String
    
    // MARK:- Init
    init(view: YesOrNoPopUpVCProtocol, title: String) {
        self.view = view
        self.title = title
    }
}

// MARK:- ViewModel Protocol
extension YesOrNoPopUpViewModel: YesOrNoPopUpViewModelProtocol {
    func getTitle() -> String {
        return title
    }
}
