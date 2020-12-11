//
//  HomeViewModel.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 08/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

protocol HomeViewModelProtocol {
    func getCategoriesCount() -> Int
    func configure(cell: CategoryCell, for index: Int)
    func mainCategoriesData()
    func didSelectItem(item: Int)
}

class HomeViewModel {
    
    //MARK:- Properties
    private weak var view: HomeVCProtocol?
    private var categoriesData = [MainCategoriesData]()
    
    // MARK:- init
    init(view: HomeVCProtocol) {
        self.view = view
    }

}

//MARK:- Public Methods
extension HomeViewModel: HomeViewModelProtocol {
    func mainCategoriesData() {
        view?.showLoader()
        APIManager.mainCategories { [weak self] (result) in
            switch result {
            case .success(let response):
                let data = response.data
                self?.categoriesData = data
                
                DispatchQueue.main.async {
                    self?.view?.reloadCollectionView()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.view?.hideLoader()
        }
    }
    
    func getCategoriesCount() -> Int {
        return categoriesData.count
    }
    
    func configure(cell: CategoryCell, for index: Int) {
        let category = categoriesData[index]
        cell.categoryLabel.text = category.name
        cell.backgroundColor = view?.color(category.color)
        view?.getImage(imageView: cell.categoryImgView, imageUrl: category.image)
    }
    
    func didSelectItem(item: Int) {
        switch (item) {
        case (0):
            print(item)
        case (1):
            print(item)
        case (2):
            print(item)
        case (3):
            print(item)
        default:
            break
        }
    }
}
