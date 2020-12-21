//
//  MyAppointmentsViewModel.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 21/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

protocol MyAppointmentsViewModelProtocol {
    func getFavoriteItemsCount() -> Int
    func getItems() -> [MyAppointmentItem]
    func willDisplayCell(for row: Int)
    func loadData()
}

class MyAppointmentsViewModel {
    //MARK:- Properties
    private weak var view: MyAppointmentsVCProtocol?
    private var appointmentItems = [MyAppointmentItem]()
    private var currentPage: Int!
    private var lastPage: Int!
    
    // MARK:- Init
    init(view: MyAppointmentsVCProtocol) {
        self.view = view
    }
}

//MARK:- Private Methods
extension MyAppointmentsViewModel {
    private func getAppointments() {
        APIManager.appointments(for: currentPage) { (result) in
            switch result {
                
            case .success(let response):
                let data = response.data
                let items = data.items
                self.lastPage = data.total_pages
                self.appointmentItems += items
                
                if self.appointmentItems.count != 0 {
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
        }
    }
    
    private func loadMoreData() {
        if currentPage < lastPage {
            currentPage += 1
            getAppointments()
        }
    }
}

//MARK:- MyAppointmentsViewModel Protocol
extension MyAppointmentsViewModel: MyAppointmentsViewModelProtocol {
    func getFavoriteItemsCount() -> Int {
        return appointmentItems.count
    }
    
    func getItems() -> [MyAppointmentItem] {
        return self.appointmentItems
    }
    
    func willDisplayCell(for row: Int) {
        if row == self.appointmentItems.count - 1 {
            self.loadMoreData()
        }
    }
    
    func loadData() {
        self.appointmentItems.removeAll()
        self.currentPage = 1
        getAppointments()
    }
}
