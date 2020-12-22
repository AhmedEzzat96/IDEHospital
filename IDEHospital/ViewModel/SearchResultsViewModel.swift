//
//  SearchResultsViewModel.swift
//  IDEHospital
//
//  Created by Ziad on 12/21/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

protocol SearchResultsViewModelProtocol {
    func searchForDoctors(with doctorsFilter: DoctorsFilter)
    func getSortTypes() -> [String]
    func sortTypeSelected(row: Int)
    func getItemsCount() -> Int
    func getItem(for row: Int) -> Item
    func willDisplay(_ row: Int)
}

class SearchResultsViewModel {
    
    // MARK:- Properties
    private weak var view: SearchResultsVCProtocol?
    var doctorsFilter: DoctorsFilter!
    private var data: SearchResults!
    
    // MARK:- Init
    init(view: SearchResultsVCProtocol) {
        self.view = view
    }
}

// MARK:- Private Methods
extension SearchResultsViewModel {
    private func getDoctors(reloadToTop: Bool = false) {
        view?.showLoader()
        APIManager.searchForDoctors(with: doctorsFilter) { [weak self] (response) in
            switch response {
            case .success(let response):
                guard response.code == 200 else { break }
                if self?.doctorsFilter.page == 1 {
                    self?.data = response.data
                } else {
                    self?.data.items += response.data.items
                }
                self?.reloadTableView(toTop: reloadToTop)
                guard response.data.items.count == 0 else { break }
                self?.view?.showNoDoctrosFoundLabel()
            case .failure(let error):
                print(error)
                self?.view?.showAlert(title: L10n.sorry, message: error.localizedDescription)
            }
            self?.view?.hideLoader()
        }
    }
    
    private func reloadTableView(toTop: Bool) {
        if toTop {
            view?.reloadToTop()
        } else {
            view?.reloadData()
        }
    }
}

// MARK:- ViewModel Protocol
extension SearchResultsViewModel: SearchResultsViewModelProtocol {
    func searchForDoctors(with doctorsFilter: DoctorsFilter) {
        self.doctorsFilter = doctorsFilter
        getDoctors()
    }
    
    func getSortTypes() -> [String] {
        return [DoctorsFilter.SortType.rating.rawValue, DoctorsFilter.SortType.fees.rawValue]
    }
    
    func sortTypeSelected(row: Int) {
        let sortType = getSortTypes()[row]
        view?.showSortType(sortType)
        doctorsFilter.orderBy = sortType
        doctorsFilter.page = 1
        getDoctors(reloadToTop: true)
    }
    
    func getItemsCount() -> Int {
        if let count = data?.items.count {
            return count
        } else {
            return 0
        }
    }
    
    func getItem(for row: Int) -> Item {
        return data.items[row]
    }
    
    func willDisplay(_ row: Int) {
        if row == self.data.items.count - 1, doctorsFilter.page < data.totalPages {
            doctorsFilter.page += 1
            getDoctors()
        }
    }
}
