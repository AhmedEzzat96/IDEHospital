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
}

class HomeNurseViewModel {
    
    // MARK:- Properties
    private weak var view: HomeNurseVCProtocol?
    
    // MARK:- Init
    init(view: HomeNurseVCProtocol) {
        self.view = view
    }
}

extension HomeNurseViewModel: HomeNurseViewModelProtocol {
    func textViewShouldEndEditing(text: String) {
        if text.isEmpty {
            view?.addPlaceholder()
        }
    }
}
