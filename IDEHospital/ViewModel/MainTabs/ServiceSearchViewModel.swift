//
//  ServiceSearchViewModel.swift
//  IDEHospital
//
//  Created by Ziad on 12/10/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

protocol ServiceSearchViewModelProtocol {
    var items: [String] { get set }
    func prepareCategories(with categoryID: Int)
    func preparePickerItems(with tag: Int)
    func itemSelected(tag: Int, row: Int)
}

class ServiceSearchViewModel {
    
    // MARK:- Properties
    private var view: ServiceSearchVCProtocol?
    var categoryData: CategoryData!

    // This ids i will handle it later while making the find doctor API calling
    var specialtyID: Int?
    var cityID: Int?
    var regionID: Int?
    var companyID: Int?
    
    // Protocol Properties
    var items: [String] = []
    
    
    // MARK:- Init
    init(view: ServiceSearchVCProtocol) {
        self.view = view
    }
}

// MARK:- Private Methods
extension ServiceSearchViewModel {
    private func getCategories(with categoriesID: Int) {
        APIManager.getCategoriesData(with: categoriesID) { [weak self] (response) in
            switch response {
            case .failure(let error):
                self?.view?.showAlert(title: "Sorry", message: error.localizedDescription)
            case .success(let categoryResponse):
                self?.categoryData = categoryResponse.data
            }
        }
    }
}

// MARK:- ViewModel Protocol
extension ServiceSearchViewModel: ServiceSearchViewModelProtocol {
    func prepareCategories(with categoryID: Int) {
        getCategories(with: categoryID)
    }
    
    func preparePickerItems(with tag: Int) {
        guard categoryData != nil else { return }
        switch tag {
        case 1:
            items = categoryData.specialties.map{$0.name}
        case 2:
            items = categoryData.cities.map{$0.name}
        case 3:
            if let city = categoryData.cities.first(where: {$0.id == cityID}) {
                view?.doneButtonEnabled(true, for: tag)
                items = city.regions.map{$0.name}
            } else {
                items = ["Choose City first"]
                view?.doneButtonEnabled(false, for: tag)
            }
        case 4:
            items = categoryData.companies.map{$0.name}
        default: break
        }
        view?.showItems()
    }
    
    func itemSelected(tag: Int, row: Int) {
        guard items.indices.contains(row) else { return }
        switch tag {
        case 1:
            let specialty = categoryData.specialties[row]
            view?.addSelectedItem(tag, specialty.name)
            specialtyID = specialty.id
        case 2:
            let city = categoryData.cities[row]
            view?.addSelectedItem(tag, city.name)
            if city.id == cityID {
                break
            }
            cityID = city.id
            view?.clearTextField(with: 3)
        case 3:
            if let city = categoryData.cities.first(where: {$0.id == cityID}) {
                let region = city.regions[row]
                view?.addSelectedItem(tag, region.name)
                regionID = region.id
            }
            view?.addSelectedItem(tag, items[row])
        case 4:
            let company = categoryData.companies[row]
            view?.addSelectedItem(tag, company.name)
            companyID = company.id
        default: break
        }
    }
    
}
