//
//  UnAuthenticatedPopUpVC.swift
//  IDEHospital
//
//  Created by Ziad on 1/10/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit

typealias AuthFields = (email: String?, password: String?, name: String?, mobile: String?, isVoucherEnabled: Bool, isBookingForAnotherEnabled: Bool, voucher: String?, patientName: String?)

protocol UnAuthenticatedPopUpVCProtocol: class {
    func showAlert(_ type: PopUpType)
    func showSuccessfullyBookedAlert(message: String)
    func getRegisterationData() -> AuthFields
    func getLoginData() -> AuthFields
    func askForConfirmation(for timestamp: Int, doctorName: String, delegate: DoctorProfilePopupsDelegate)
    func dismiss()
}

class UnAuthenticatedPopUpVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var mainView: UnAuthenticatedPopUpView!
    
    // MARK:- Properties
    private var viewModel: UnAuthenticatedPopUpViewModelProtocol!
    private weak var delegate: DoctorProfilePopupsDelegate?
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setup()
        mainView.switchDisplayedView(toLogin: false, toRegister: true, authAndBookButtonTitle: L10n.signUpAndBook)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.6, delay: 0.2, options: .curveEaseInOut, animations: {
            self.view.backgroundColor = ColorName.greyishBrown87.color.withAlphaComponent(0.87)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view == view.subviews.first {
            view.endEditing(true)
        } else if touch?.view == self.view {
            dismissCurrent()
        }
    }
    
    // MARK:- Public Methods
    class func create(booking: UserAndBooking, delegate: DoctorProfilePopupsDelegate) -> UnAuthenticatedPopUpVC {
        let unAuthPopUpVC: UnAuthenticatedPopUpVC = UIViewController.create(storyboardName: Storyboards.unAuthPopUp, identifier: ViewControllers.unAuthPopUpVC)
        unAuthPopUpVC.viewModel = UnAuthenticatedPopUpViewModel(view: unAuthPopUpVC, displayedView: .register, userAndBooking: booking)
        unAuthPopUpVC.delegate = delegate
        return unAuthPopUpVC
    }

    // MARK:- Actions
    @IBAction func registerViewButtonPressed(_ sender: Any) {
        mainView.switchDisplayedView(toLogin: false, toRegister: true, authAndBookButtonTitle: L10n.signUpAndBook)
        viewModel.configureDisplayedView(.register)
    }
    
    @IBAction func loginViewButtonPressed(_ sender: Any) {
        mainView.switchDisplayedView(toLogin: true, toRegister: false, authAndBookButtonTitle: L10n.loginAndBook)
        viewModel.configureDisplayedView(.login)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismissCurrent()
    }
    
    @IBAction func registerHaveVoucherCheckMarkPressed(_ sender: UIButton) {
        mainView.handleCheckMarkButtonAndTextField(sender, mainView.registerVoucherTextField)
    }
    
    @IBAction func registerBookingForAnotherCheckMarkPressed(_ sender: UIButton) {
        mainView.handleCheckMarkButtonAndTextField(sender, mainView.registerPatientNameTextField)
    }
    
    @IBAction func loginHaveVoucherCheckMarkPressed(_ sender: UIButton) {
        mainView.handleCheckMarkButtonAndTextField(sender, mainView.loginVoucherTextField)
    }
    
    @IBAction func loginBookingForAnotherCheckMarkPressed(_ sender: UIButton) {
        mainView.handleCheckMarkButtonAndTextField(sender, mainView.loginPatientNameTextField)
    }
    
    @IBAction func authAndBookButtonPressed(_ sender: CustomButton) {
        viewModel.authAndBookTapped()
    }
    
    @IBAction func termsButtonPressed(_ sender: UIButton) {
        let termsVC = AboutAndTermsVC.create(status: .termsAndConditions)
        let termsNav = UINavigationController(rootViewController: termsVC)
        termsNav.modalPresentationStyle = .fullScreen
        present(termsNav, animated: true)
    }
}

// MARK:- UnAuthVC Protocol
extension UnAuthenticatedPopUpVC: UnAuthenticatedPopUpVCProtocol {
    func showAlert(_ type: PopUpType) {
        showSimpleAlert(type: type)
    }
    
    func showSuccessfullyBookedAlert(message: String) {
        showSimpleAlert(type: .success(message), okButtonAction: .delegation, delegate: self)
    }
    
    func getRegisterationData() -> AuthFields {
        return AuthFields(email: mainView.registerEmailTextField.text, password:  mainView.registerPasswordTextField.text, name: mainView.registerNameTextField.text, mobile: mainView.registerPhoneTextField.text, isVoucherEnabled: mainView.registerHaveVoucherButton.isSelected, isBookingForAnotherEnabled: mainView.registerBookForAnotherButton.isSelected, voucher: mainView.registerVoucherTextField.text, patientName: mainView.registerPatientNameTextField.text)
    }
    
    func getLoginData() -> AuthFields {
        return AuthFields(email: mainView.loginEmailTextField.text, password:  mainView.loginPasswordTextField.text, name: nil, mobile: nil, isVoucherEnabled: mainView.loginHaveVoucherButton.isSelected, isBookingForAnotherEnabled: mainView.loginBookForAnotherButton.isSelected, voucher: mainView.loginVoucherTextField.text, patientName: mainView.loginPatientNameTextField.text)
    }
    
    func askForConfirmation(for timestamp: Int, doctorName: String, delegate: DoctorProfilePopupsDelegate) {
        let confirmationPopUp = ConfirmAppointmentPopUpVC.create(for: timestamp, doctorName: doctorName)
        confirmationPopUp.delegate = delegate
        present(confirmationPopUp, animated: true)
    }
    
    func dismiss() {
        dismissCurrent()
    }
}

// MARK:- SuccessOrFailurePopUp Protocol
extension UnAuthenticatedPopUpVC: SuccessOrFailurePopUpOkButtonDelegate {
    func okTapped() {
        delegate?.authenticatedAndBooked()
        dismissCurrent()
    }
}
