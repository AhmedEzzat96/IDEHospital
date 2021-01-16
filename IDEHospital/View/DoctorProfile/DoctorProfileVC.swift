//
//  DoctorProfileVC.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 03/01/2021.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit
import SDWebImage

protocol DoctorProfileVCProtocol: class {
    func reloadTableView()
    func showDoctorData(item: DoctorData)
    func showDate(date: String)
    func reloadCollectionView()
    func showVoucherPopup(appointment: Appointment, doctorName: String, delegate: DoctorProfilePopupsDelegate)
    func goToAddReview(with doctorID: Int)
    func showAlert(type: PopUpType)
    func showLoader()
    func hideLoader()
    func hideNoAppointmentsLabel(_ isHidden: Bool)
    func askForConfirmation(with timestamp: Int, doctorName: String, delegate: DoctorProfilePopupsDelegate)
    func showAuthAndBookPopUp(for booking: UserAndBooking, delegate: DoctorProfilePopupsDelegate)
}

class DoctorProfileVC: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var doctorProfileView: DoctorProfileView!
    
    // MARK:- Properties
    private var viewModel: DoctorProfileViewModelProtocol!
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        doctorProfileView.setup()
        collectionViewConfig()
        tableViewConfig()
        setupNavigation()
        doctorProfileBtnPressed(doctorProfileView.doctorProfileBtn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDoctorData()
    }
    
    // MARK:- Public Methods
    class func create(with doctorID: Int) -> DoctorProfileVC {
        let doctorProfileVC: DoctorProfileVC = UIViewController.create(storyboardName: Storyboards.doctorProfile, identifier: ViewControllers.doctorProfileVC)
        doctorProfileVC.viewModel = DoctorProfileViewModel(view: doctorProfileVC, doctorID: doctorID)
        doctorProfileVC.getDoctorData()
        return doctorProfileVC
    }
    
    // MARK:- IBActions
    @IBAction func doctorProfileBtnPressed(_ sender: UIButton) {
        doctorProfileView.hideOrShowDoctorDetails()
    }
    
    @IBAction func addReviewButtonPressed(_ sender: UIButton) {
        viewModel.addReviewTapped()
    }
    
    @IBAction func bookNowBtnPressed(_ sender: CustomButton) {
        viewModel.checkAuthAndShowPopUp()
    }
    
    @IBAction func reviewsBtnPressed(_ sender: UIButton) {
        doctorProfileView.hideOrShowDoctorDetails(dotorProfileBtn: false, reviewBtn: true, doctorView: true, tableViewHidden: false)
    }
    
    @IBAction func previousDateBtnPressed(_ sender: UIButton) {
        viewModel.getDate(dateDirection: .previous)
    }
    
    @IBAction func nextDateBtnPressed(_ sender: UIButton) {
        viewModel.getDate(dateDirection: .next)
    }
    
    @IBAction func favoriteBtnPressed(_ sender: UIButton) {
        viewModel.addRemoveFavorite()
    }
    
    @IBAction func viewOnMapBtnPressed(_ sender: UIButton) {
        viewModel.openMapForPlace()
    }
}

// MARK:- Private Methods
extension DoctorProfileVC {
    private func collectionViewConfig() {
        doctorProfileView.collectionView.delegate = self
        doctorProfileView.collectionView.dataSource = self
        doctorProfileView.collectionView.register(UINib(nibName: Cells.timeCell, bundle: nil), forCellWithReuseIdentifier: Cells.timeCell)
    }
    
    private func tableViewConfig() {
        doctorProfileView.tableView.delegate = self
        doctorProfileView.tableView.dataSource = self
        doctorProfileView.tableView.register(UINib(nibName: Cells.reviewCell, bundle: nil), forCellReuseIdentifier: Cells.reviewCell)
    }
    
    private func getDoctorData() {
        viewModel.getDoctor()
        viewModel.getDoctorAppointment(fromBeginning: true)
        viewModel.loadReviewData()
    }
    
    private func setupNavigation() {
        self.setupNavController(title: L10n.searchResults)
        self.setupNavigationItems(backAction: .popUpCurrent)
    }
}

// MARK:- CollectionView DataSource
extension DoctorProfileVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getTimeItemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = doctorProfileView.collectionView.dequeueReusableCell(withReuseIdentifier: Cells.timeCell, for: indexPath) as! TimeCell
        cell.configure(item: viewModel.getTime(for: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        doctorProfileView.bookNowBtn.isEnabled = true
        cell?.backgroundColor = ColorName.darkRoyalBlue.color
        viewModel.didSelectItem(with: indexPath.item)

    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = ColorName.niceBlue.color
        collectionView.deselectItem(at: indexPath, animated: true)
    }

}

// MARK:- TableView DataSource
extension DoctorProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getReviewItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = doctorProfileView.tableView.dequeueReusableCell(withIdentifier: Cells.reviewCell, for: indexPath) as! ReviewCell
        cell.configure(item: viewModel.getReviewItem(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.willDisplayReviewCell(for: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

// MARK:- DoctorProfileVC Protocol
extension DoctorProfileVC: DoctorProfileVCProtocol {
    func showDoctorData(item: DoctorData) {
        doctorProfileView.showDoctorData(item: item)
    }
    
    func reloadTableView() {
        self.doctorProfileView.tableView.reloadData()
    }
    
    func showDate(date: String) {
        doctorProfileView.dateLabel.text = date
    }
    
    
    func reloadCollectionView() {
        doctorProfileView.collectionView.reloadData()
        doctorProfileView.bookNowBtn.isEnabled = false
    }
    
    func showVoucherPopup(appointment: Appointment, doctorName: String, delegate: DoctorProfilePopupsDelegate) {
        let voucherVC = VoucherPopUpVC.create(appointment: appointment, doctorName: doctorName)
        voucherVC.delegate = delegate
        self.present(voucherVC, animated: true)
    }
    
    func goToAddReview(with doctorID: Int) {
        let reviewVC = ReviewVC.create(for: doctorID)
        navigationController?.pushViewController(reviewVC, animated: true)
    }
    
    func showAlert(type: PopUpType) {
        showSimpleAlert(type: type)
    }
    
    func showLoader() {
        view.showActivityIndicator()
    }
    
    func hideLoader() {
        view.hideActivityIndicator()
    }
    
    func hideNoAppointmentsLabel(_ isHidden: Bool) {
        DispatchQueue.main.async {
            self.doctorProfileView.noAppointmentsForDateLabel.isHidden = isHidden
        }
    }
    
    func askForConfirmation(with timestamp: Int, doctorName: String, delegate: DoctorProfilePopupsDelegate) {
        let confirmationPopUp = ConfirmAppointmentPopUpVC.create(for: timestamp, doctorName: doctorName)
        present(confirmationPopUp, animated: true)
        confirmationPopUp.delegate = delegate
    }
    
    func showAuthAndBookPopUp(for booking: UserAndBooking, delegate: DoctorProfilePopupsDelegate) {
        let authPopUpVC = UnAuthenticatedPopUpVC.create(booking: booking, delegate: delegate)
        present(authPopUpVC, animated: true)
    }
}
