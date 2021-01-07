//
//  DoctorProfileViewModel.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 04/01/2021.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import Foundation
import MapKit

enum DateDirection {
    case previous
    case next
}

protocol DoctorProfileViewModelProtocol {
    func getDoctor(with id: Int)
    func willDisplayReviewCell(for row: Int)
    func loadReviewData(with doctorID: Int)
    func getReviewItem(at index: Int) -> ReviewsItem
    func getReviewItemsCount() -> Int
    func getDate(dateDirection: DateDirection?)
    func getDoctorAppointment(with doctorID: Int)
    func getTime(for item: Int) -> DoctorAppointmentTime
    func getTimeItemsCount() -> Int
    func addRemoveFavorite()
    func didSelectItem(with item: Int)
    func getLastSelectedIndex() -> Int?
    func openMapForPlace()
    func showVoucher()
    func viewWillAppear()
    func addReviewTapped()
}

class DoctorProfileViewModel {
    // MARK:- Properties
    private weak var view: DoctorProfileVCProtocol?
    private var reviewsItem = [ReviewsItem]()
    private var appointmentsDate = [DoctorAppointmentData]()
    private var doctorData: DoctorData?
    private var currentPage: Int!
    private var lastPage: Int!
    private var dateIndex = 0
    private var lastSelectedAppointmentIndex: Int?
    private var selectedAppointment: Int?
    
    // MARK:- Init
    init(view: DoctorProfileVCProtocol) {
        self.view = view
    }
}

// MARK:- Private Methods
extension DoctorProfileViewModel {
    private func getReviews(with id: Int) {
        view?.showLoader()
        APIManager.reviews(with: id, page: currentPage) { [weak self] (result) in
            switch result {
            case .success(let response):
                if response.code == 200 && response.success == true {
                    guard let items = response.data?.items else { return }
                    self?.lastPage = response.data?.total_pages
                    self?.reviewsItem += items
                    self?.view?.reloadTableView()
                }
            case .failure(let error):
                print(error)
            }
            self?.view?.hideLoader()
        }
    }
    
    private func loadMoreReviewData(with DoctorID: Int) {
        if currentPage < lastPage {
            currentPage += 1
            getReviews(with: DoctorID)
        }
    }
    
    private func createDate(timestamp: Int) -> String {
        var strDate = ""
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
        dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = L10n.dateFormat //Specify your format that you want
        strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    private func createTime(timestamp: Int) -> String {
        var strDate = ""
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
        dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = L10n.timeFormat //Specify your format that you want
        dateFormatter.amSymbol = L10n.am
        dateFormatter.pmSymbol = L10n.pm
        strDate = dateFormatter.string(from: date)
        return strDate
    }
}

// MARK:- DoctorProfileViewModel Protocol
extension DoctorProfileViewModel: DoctorProfileViewModelProtocol {
    func getDoctor(with id: Int) {
        view?.showLoader()
        APIManager.doctors(with: id) { [weak self] (result) in
            switch result {
                
            case .success(let response):
                print(response.code)
                if response.code == 200 && response.success == true {
                    guard let data = response.data else { return }
                    self?.doctorData = data
                    self?.view?.showDoctorData(item: data)
                    self?.view?.reloadCollectionView()
                }
            case .failure(let error):
                print(error)
            }
            self?.view?.hideLoader()
        }
    }
    
    func addRemoveFavorite() {
        guard let doctorID = self.doctorData?.id else { return }
        APIManager.addRemoveFavorite(with: doctorID) { [weak self] (success) in
            if success {
                self?.getDoctor(with: doctorID)
            }
        }
    }
    
    func getDoctorAppointment(with doctorID: Int) {
        view?.showLoader()
        APIManager.doctorAppointments(with: doctorID) { [weak self] (result) in
            switch result {
            case .success(let response):
                if response.code == 200 && response.success == true {
                    guard let data = response.data else { return }
                    self?.appointmentsDate = data
                    self?.getDate()
                    self?.view?.reloadCollectionView()
                }
            case .failure(let error):
                print(error)
            }
            self?.view?.hideLoader()
        }
    }
    
    
    
    func getDate(dateDirection: DateDirection? = nil) {
        switch dateDirection {
        case .previous:
            if dateIndex > 0 {
                dateIndex -= 1
            }
        case .next:
            if dateIndex < appointmentsDate.count - 1 {
                dateIndex += 1
            }
        case .none:
            dateIndex = 0
        }
        DispatchQueue.main.async {
            self.view?.showDate(date: self.createDate(timestamp: self.appointmentsDate[self.dateIndex].date))
            self.view?.reloadCollectionView()
        }
    }
    
    func getTime(for item: Int) -> DoctorAppointmentTime {
        return appointmentsDate[dateIndex].times[item]
    }
    
    func getTimeItemsCount() -> Int {
        guard appointmentsDate.indices.contains(dateIndex) else { return 0 }
        view?.hideNoAppointmentsLabel(appointmentsDate[dateIndex].times.count != 0)
        return appointmentsDate[dateIndex].times.count
    }
    
    func getReviewItemsCount() -> Int {
        return reviewsItem.count
    }
    
    func loadReviewData(with doctorID: Int) {
        self.reviewsItem.removeAll()
        self.currentPage = 1
        getReviews(with: doctorID)
    }
    
    func willDisplayReviewCell(for row: Int) {
        guard let doctorID = self.doctorData?.id else { return }
        if row == self.reviewsItem.count - 1 {
            self.loadMoreReviewData(with: doctorID)
        }
    }
    
    func didSelectItem(with item: Int) {
        let appointment = appointmentsDate[dateIndex].times[item].time
        self.selectedAppointment = appointment
    }
    
    func getLastSelectedIndex() -> Int? {
        return lastSelectedAppointmentIndex
    }
    
    func showVoucher() {
        guard let doctorID = doctorData?.id, let timeStamp = selectedAppointment, let doctorName = doctorData?.name else { return }
        self.view?.showPopup(doctorID: doctorID, timeStamp: timeStamp, doctorName: doctorName)
    }
    
    func getReviewItem(at index: Int) -> ReviewsItem {
        return self.reviewsItem[index]
    }
    
    func openMapForPlace() {
        let latitude: CLLocationDegrees = doctorData?.lat ?? 0
        let longitude: CLLocationDegrees = doctorData?.lng ?? 0

        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = doctorData?.address
        mapItem.openInMaps(launchOptions: options)
    }
    
    func viewWillAppear() {
        if let doctorID = doctorData?.id {
            getDoctor(with: doctorID)
        }
    }
    
    func addReviewTapped() {
        guard UserDefaultsManager.shared().token != nil else {
            view?.showAlert(type: .failure(L10n.mustRegister))
            return
        }
        if let doctorID = doctorData?.id {
            view?.goToAddReview(with: doctorID)
        } else {
            view?.showAlert(type: .failure(L10n.responseError))
        }
    }
}
