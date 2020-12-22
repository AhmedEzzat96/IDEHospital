//
//  MyAppointmentsViewModel.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 21/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation
import MapKit
protocol MyAppointmentsViewModelProtocol {
    func getFavoriteItemsCount() -> Int
    func getItem(at index: Int) -> MyAppointmentItem
    func willDisplayCell(for row: Int)
    func loadData()
    func showDeleteAlert(with row: Int)
    func openMapForPlace(for row: Int)
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
        self.view?.showLoader()
        APIManager.appointments(for: currentPage) { [weak self] (result) in
            guard let self = self else { return }
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
            self.view?.hideLoader()
        }
    }
    
    private func loadMoreData() {
        if currentPage < lastPage {
            currentPage += 1
            getAppointments()
        }
    }
    
    private func removeAppointment(with row: Int) {
        APIManager.removeAppointment(with: appointmentItems[row].id) { [weak self] (success) in
            if success {
                self?.appointmentItems.removeAll()
                self?.loadData()
            }
        }
    }
}

//MARK:- MyAppointmentsViewModel Protocol
extension MyAppointmentsViewModel: MyAppointmentsViewModelProtocol {
    func getFavoriteItemsCount() -> Int {
        return appointmentItems.count
    }
    
    func getItem(at index: Int) -> MyAppointmentItem {
        return self.appointmentItems[index]
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
    
    func showDeleteAlert(with row: Int) {
        view?.showAlert(title: L10n.sorry, message: L10n.deleteAppointment, actions: [nil, { [weak self] yesAction in
            self?.removeAppointment(with: row)
            }])
    }
    
    func openMapForPlace(for row: Int) {
        let latitude: CLLocationDegrees = appointmentItems[row].doctor.lat
        let longitude: CLLocationDegrees = appointmentItems[row].doctor.lng

        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = appointmentItems[row].doctor.address
        mapItem.openInMaps(launchOptions: options)
    }
}
