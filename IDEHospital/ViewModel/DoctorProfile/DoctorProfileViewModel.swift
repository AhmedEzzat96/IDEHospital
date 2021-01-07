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
    func getDoctor()
    func willDisplayReviewCell(for row: Int)
    func loadReviewData()
    func getReviewItem(at index: Int) -> ReviewsItem
    func getReviewItemsCount() -> Int
    func getDate(dateDirection: DateDirection?)
    func getDoctorAppointment(fromBeginning: Bool)
    func getTime(for item: Int) -> DoctorAppointmentTime
    func getTimeItemsCount() -> Int
    func addRemoveFavorite()
    func didSelectItem(with item: Int)
    func getLastSelectedIndex() -> Int?
    func openMapForPlace()
    func showVoucher()
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
    private var appointment: Appointment!
    
    // MARK:- Init
    init(view: DoctorProfileVCProtocol, doctorID: Int) {
        self.view = view
        self.appointment = Appointment(doctorID: doctorID)
    }
}

// MARK:- Private Methods
extension DoctorProfileViewModel {
    private func getReviews() {
        view?.showLoader()
        APIManager.reviews(with: appointment.doctorID, page: currentPage) { [weak self] (result) in
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
            getReviews()
        }
    }
    
    private func checkAppointmentResponse(_ response: AppointmentResponse) {
        if response.success == true, response.code == 202 {
            view?.showAlert(type: .success(L10n.successfullyBooked))
            self.getDoctorAppointment(fromBeginning: false)
        } else if let responseMessage = response.message {
            view?.showAlert(type: .failure(responseMessage))
        } else if let voucherError = response.errors?.voucher?[0] {
            view?.showAlert(type: .failure(voucherError))
        } else if let appointmentError = response.errors?.appointment?[0] {
            view?.showAlert(type: .failure(appointmentError))
        }
    }
    
    private func bookAppointment() {
        APIManager.bookAppointment(appointment) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.checkAppointmentResponse(response)
            case .failure(let error):
                print(error)
                self?.view?.showAlert(type: .failure(L10n.responseError))
            }
        }
    }
}

// MARK:- DoctorProfileViewModel Protocol
extension DoctorProfileViewModel: DoctorProfileViewModelProtocol {
    func getDoctor() {
        view?.showLoader()
        APIManager.doctors(with: appointment.doctorID) { [weak self] (result) in
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
        guard UserDefaultsManager.shared().token != nil else {
            view?.showAlert(type: .failure(L10n.mustAuthenticate))
            return
        }
        guard let doctorID = self.doctorData?.id else { return }
        APIManager.addRemoveFavorite(with: doctorID) { [weak self] (success) in
            if success {
                self?.getDoctor()
            }
        }
    }
    
    func getDoctorAppointment(fromBeginning: Bool) {
        view?.showLoader()
        APIManager.doctorAppointments(with: appointment.doctorID) { [weak self] (result) in
            switch result {
            case .success(let response):
                if response.code == 200 && response.success == true {
                    guard let data = response.data else { return }
                    self?.appointmentsDate = data
                    if fromBeginning { self?.getDate() }
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
            guard self.appointmentsDate.indices.contains(self.dateIndex) else { return }
            self.view?.showDate(date: self.appointmentsDate[self.dateIndex].date.createDate())
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
    
    func loadReviewData() {
        self.reviewsItem.removeAll()
        self.currentPage = 1
        getReviews()
    }
    
    func willDisplayReviewCell(for row: Int) {
        guard let doctorID = self.doctorData?.id else { return }
        if row == self.reviewsItem.count - 1 {
            self.loadMoreReviewData(with: doctorID)
        }
    }
    
    func didSelectItem(with item: Int) {
        self.appointment.timestamp = appointmentsDate[dateIndex].times[item].time
    }
    
    func getLastSelectedIndex() -> Int? {
        return lastSelectedAppointmentIndex
    }
    
    func showVoucher() {
        guard UserDefaultsManager.shared().token != nil else {
            self.view?.showAlert(type: .failure(L10n.mustAuthenticate))
            return
        }
        guard appointment.timestamp != nil, let doctorName = doctorData?.name else { return }
        self.view?.showVoucherPopup(appointment: self.appointment, doctorName: doctorName, delegate: self)
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

// MARK:- Popups Delegate
extension DoctorProfileViewModel: DoctorProfilePopupsDelegate {
    func continueTapped(appointment: Appointment, doctorName: String) {
        self.appointment = appointment
        view?.askForConfirmation(with: appointment, doctorName: doctorName, delegate: self)
    }
    
    func confirmTapped() {
        bookAppointment()
    }
}

extension DoctorProfileViewModel: SuccessOrFailurePopUpOkButtonDelegate {
    func okTapped() {
        getReviews()
    }
}
