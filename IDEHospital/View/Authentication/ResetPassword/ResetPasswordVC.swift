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
    @IBOutlet var resetPasswordView: ResetPasswordView!
    
    //MARK:- Properties
    private var viewModel: ResetPasswordViewModelProtocol!
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPasswordView.setup()
        setupNavigation()
        self.viewModel = ResetPasswordViewModel(view: self)
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
        self.setupNavigationItems(backAction: .popUpCurrent)
    }
}

//MARK:- Auth Protocol
extension ResetPasswordVC: AuthProtocol {
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        self.showSimpleAlert(title: title, message: message, handler: handler)
    }
    
    func goToHomeScreen() {
        let window = AppDelegate.sharedInstance().window
        let homeVC = HomeVC.create()
        let homeNav = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = homeNav
        
    }
    
    func showLoader() {
        self.view.showActivityIndicator()
    }
    
    func hideLoader() {
        self.view.hideActivityIndicator()
    }
}
