//
//  ResetPasswordVC.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 26/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var resetPasswordView: ResetPasswordView!
    
    //MARK:- Properties
    private var viewModel: ResetPasswordViewModelProtocol!
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPasswordView.setup()
        setupNavigation()
    }
    
    //MARK:- Public Methods
    class func create() -> ResetPasswordVC {
        let resetPasswordVC: ResetPasswordVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.resetPasswordVC)
        resetPasswordVC.viewModel = ResetPasswordViewModel(view: resetPasswordVC)
        return resetPasswordVC
    }
    
    //MARK:- IBActions
    @IBAction func setNewPasswordBtnPressed(_ sender: CustomButton) {
        let user = User(email: resetPasswordView.emailTextField.text)
        viewModel.goToHome(user: user)
    }
    
}

//MARK:- Private Methods
extension ResetPasswordVC {
    private func setupNavigation() {
        self.setupNavController(title: L10n.resetPassword)
        self.setupNavigationItems(backAction: .popUpCurrent, isSettingEnable: false)
    }
}

//MARK:- Auth Protocol
extension ResetPasswordVC: AuthProtocol {
    func showAlert(_ type: PopUpType, okButtonAction: OkButtonAction) {
        showSimpleAlert(type: type, okButtonAction: okButtonAction)
    }
    
    func goToHomeScreen() {
        switchToHome()
    }
    
    func showLoader() {
        self.view.showActivityIndicator()
    }
    
    func hideLoader() {
        self.view.hideActivityIndicator()
    }
}
