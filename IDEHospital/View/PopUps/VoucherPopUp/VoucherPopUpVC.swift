//
//  VoucherPopUpVC.swift
//  IDEHospital
//
//  Created by Ziad on 1/5/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit

protocol VoucherPopUpVCProtocol: class {
    func getVoucherCode() -> String?
    func getPatientName() -> String?
    func showAlert(title: String, message: String)
    func askForConfirmation(for appointment: Appointment, doctorName: String)
}

class VoucherPopUpVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var mainView: VoucherPopUpView!
    
    // MARK:- Properties
    var viewModel: VoucherPopUpViewModelProtocol!
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setup()
        setSwitchTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.4, delay: 0.2, options: .curveEaseInOut, animations: {
            self.view.backgroundColor = ColorName.greyishBrown87.color.withAlphaComponent(0.87)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view == view.subviews.first {
            view.endEditing(true)
        } else {
            dismissCurrent()
        }
    }
    
    // MARK:- Public Methods
    class func create(doctorID: Int, timestamp: Int, doctorName: String) -> VoucherPopUpVC {
        let voucherPopUpVC: VoucherPopUpVC = UIViewController.create(storyboardName: Storyboards.voucherPopUp, identifier: ViewControllers.voucherPopUpVC)
        voucherPopUpVC.viewModel = VoucherPopUpViewModel(view: voucherPopUpVC, doctorID: doctorID, timestamp: timestamp, doctorName: doctorName)
        return voucherPopUpVC
    }
    
    // MARK:- Actions
    @IBAction func continueButtonPressed(_ sender: CustomButton) {
        viewModel.continueTapped(mainView.voucherSwitch.isOn, mainView.anotherPersonSwitch.isOn)
    }
}

extension VoucherPopUpVC {
    // MARK:- Private Methods
    private func setSwitchTarget() {
        mainView.voucherSwitch.addTarget(self, action: #selector(voucherSwitchValueChanged), for: .valueChanged)
        mainView.anotherPersonSwitch.addTarget(self, action: #selector(anotherPersonSwitchValueChanged), for: .valueChanged)
    }
    
    // MARK:- Objc Methods
    @objc private func voucherSwitchValueChanged() {
        mainView.voucherCodeTextField.isHidden = !mainView.voucherCodeTextField.isHidden
        mainView.voucherCodeTextField.resignFirstResponder()
    }
    
    @objc private func anotherPersonSwitchValueChanged() {
        mainView.anotherPersonNameTextField.isHidden = !mainView.anotherPersonNameTextField.isHidden
        mainView.anotherPersonNameTextField.resignFirstResponder()
    }
}

// MARK:- VoucherPopUpVC Protocol
extension VoucherPopUpVC: VoucherPopUpVCProtocol {
    func getVoucherCode() -> String? {
        return mainView.voucherCodeTextField.text
    }
    
    func getPatientName() -> String? {
        return mainView.anotherPersonNameTextField.text
    }
    
    func showAlert(title: String, message: String) {
        showSimpleAlert(title: title, message: message)
    }
    
    func askForConfirmation(for appointment: Appointment, doctorName: String) {
        let confirmAppointmentPopUpVC = ConfirmAppointmentPopUpVC.create(for: appointment, doctorName: doctorName)
        let topVC = self.presentingViewController
        dismiss(animated: true) {
            topVC?.present(confirmAppointmentPopUpVC, animated: true)
        }
    }
}
