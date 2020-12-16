//
//  MyFavoritesViewModel.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 15/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

protocol MyFavoritesViewModelProtocol {
    
}

class MyFavoritesViewModel {
    
    //MARK:- Properties
    private weak var view: MyFavoritesVCProtocol?
    
    // MARK:- Init
    init(view: MyFavoritesVCProtocol) {
        self.view = view
    }
    
}

//MARK:- MyFavoritesViewModel Protocol
extension MyFavoritesViewModel: MyFavoritesViewModelProtocol {
    
}
