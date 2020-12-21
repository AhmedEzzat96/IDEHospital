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
    func getFavoriteItemsCount() -> Int
    func loadData()
    func getItems() -> [MyFavoriteItem]
    func showDeleteAlert(with doctorID: Int)
    func willDisplayCell(for row: Int)
}

class MyFavoritesViewModel {
    //MARK:- Properties
    private weak var view: MyFavoritesVCProtocol?
    private var favoriteItems = [MyFavoriteItem]()
    private var currentPage: Int!
    private var lastPage: Int!
    
    // MARK:- Init
    init(view: MyFavoritesVCProtocol) {
        self.view = view
    }
}

//MARK:- MyFavoritesViewModel Protocol
extension MyFavoritesViewModel: MyFavoritesViewModelProtocol {
    func willDisplayCell(for row: Int) {
        if row == self.favoriteItems.count - 1 {
            self.loadMoreData()
        }
    }
    
    func loadData() {
        self.favoriteItems.removeAll()
        self.currentPage = 1
        getFavorites()
    }
    
    func loadMoreData() {
        if currentPage < lastPage {
            currentPage += 1
            getFavorites()
        }
    }
    
    func getFavoriteItemsCount() -> Int {
        return favoriteItems.count
    }
    
    func getItems() -> [MyFavoriteItem] {
        return self.favoriteItems
    }
    
    func showDeleteAlert(with row: Int) {
        view?.showAlert(title: L10n.sorry, message: L10n.deleteFavorite, actions: [nil, { [weak self] yesAction in
            self?.removeFavorite(with: row)
            }])
    }
}

//MARK:- Private Methods
extension MyFavoritesViewModel {
    private func getFavorites() {
        self.view?.showLoader()
        APIManager.favorites(for: currentPage) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
                
            case .success(let response):
                let data = response.data
                let items = data.items
                self.lastPage = data.total_pages
                self.favoriteItems += items
                print(self.favoriteItems.count)
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
    
    private func removeFavorite(with row: Int) {
        APIManager.addRemoveFavorite(with: favoriteItems[row].id) { [weak self] (success) in
            if success {
                self?.favoriteItems.remove(at: row)
                self?.view?.reloadData()
            }
        }
    }
}
