//
//  ConfirmAppointmentPopUpVC.swift
//  IDEHospital
//
//  Created by Ziad on 1/5/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit

protocol DismissView: class {
    func dismissPopup()
}
protocol ConfirmAppointmentPopUpVCProtocol: class {
    func showLoader()
    func hideLoader()
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?)
    func dismissPopup()
}

class ConfirmAppointmentPopUpVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var mainView: ConfirmAppointmentPopUpView!
    
    // MARK:- Properties
    var viewModel: ConfirmAppointmentPopUpViewModelProtocol!
    weak var delegate: DismissView?
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setup(viewModel.getDateAndTime(), viewModel.getDoctorName())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.4, delay: 0.2, options: .curveEaseInOut, animations: {
            self.view.backgroundColor = ColorName.greyishBrown87.color.withAlphaComponent(0.87)
        })
    }
    
    // MARK:- Public Methods
    class func create(for appointment: Appointment, doctorName: String) -> ConfirmAppointmentPopUpVC {
        let confirmAppointmentPopUpVC: ConfirmAppointmentPopUpVC = UIViewController.create(storyboardName: Storyboards.confirmAppointmentPopUp, identifier: ViewControllers.confirmAppointmentPopUpVC)
        confirmAppointmentPopUpVC.viewModel = ConfirmAppointmentPopUpViewModel(view: confirmAppointmentPopUpVC, appointment: appointment, doctorName: doctorName)
        return confirmAppointmentPopUpVC
    }
    
    // MARK:- Actions
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        let yesOrNoPopUpVC = YesOrNoPopUpVC.create(title: L10n.sureToCancel)
        present(yesOrNoPopUpVC, animated: true)
    }
    
    @IBAction func confirmButtonPressed(_ sender: CustomButton) {
        viewModel.confirmTapped()
    }
}

// MARK:- Private Methods
extension ConfirmAppointmentPopUpVC {
    
}

// MARK:- ConfirmAppointmentVC Protocol
extension ConfirmAppointmentPopUpVC: ConfirmAppointmentPopUpVCProtocol {
    func showLoader() {
        view.showActivityIndicator()
    }
    
    func hideLoader() {
        view.hideActivityIndicator()
    }
    
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        showSimpleAlert(title: title, message: message, handler: handler)
    }
    
    func dismissPopup() {
        self.delegate?.dismissPopup()
        self.dismiss(animated: true, completion: nil)
    }
}
