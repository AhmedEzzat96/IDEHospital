//
//  MyFavoritesViewModel.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 15/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation
import SDWebImage

protocol MyFavoritesViewModelProtocol {
    func getFavorites()
    func getFavoriteItemsCount() -> Int
    func getItems() -> [MyFavoriteItem]
    func showDeleteAlert(with doctorID: Int)
}

class MyFavoritesViewModel {
    
    //MARK:- Properties
    private weak var view: MyFavoritesVCProtocol?
    private var favoriteItems = [MyFavoriteItem]()
    
    // MARK:- Init
    init(view: MyFavoritesVCProtocol) {
        self.view = view
    }
    
    private func removeFavorite(with row: Int) {
        APIManager.addRemoveFavorite(with: favoriteItems[row].id) { (success) in
            if success {
                self.getFavorites()
            }
        }
    }
}

//MARK:- MyFavoritesViewModel Protocol
extension MyFavoritesViewModel: MyFavoritesViewModelProtocol {
    func getFavorites() {
        self.view?.showLoader()
        APIManager.favorites { [weak self] (result) in
            guard let self = self else { return }
            switch result {
                
            case .success(let response):
                let data = response.data
                let items = data.items
                self.favoriteItems = items
                
                if self.favoriteItems.count != 0 {
                    DispatchQueue.main.async {
                        self.view?.isHidden(tableView: false, noItemsFound: true)
                        self.view?.reloadData()
                    }
                } else {
                    self.view?.isHidden(tableView: true, noItemsFound: false)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.view?.hideLoader()
        }
    }
    
    func getFavoriteItemsCount() -> Int {
        return favoriteItems.count
    }
    
    func getItems() -> [MyFavoriteItem] {
        return self.favoriteItems
    }
    
    func showDeleteAlert(with row: Int) {
        view?.showAlert(title: L10n.sorry, message: L10n.deleteMessage, actions: [nil, { [weak self] yesAction in
            self?.removeFavorite(with: row)
            }])
    }
}
