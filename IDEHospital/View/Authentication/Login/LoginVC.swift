//
//  LoginVC.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 27/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet var loginView: LoginView!
    
    //MARK:- Properties
    private var viewModel: LoginViewModelProtocol!
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.setup()
        setupNavigation()
        self.viewModel = LoginViewModel(view: self)
        
    }
    
    //MARK:- IBActions
    @IBAction func loginBtnPressed(_ sender: CustomButton) {
        let user = User(email: loginView.emailTextField.text, password: loginView.passwordTextField.text)
        viewModel.goToHome(user: user)
    }
    
    @IBAction func forgetPasswordBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func signupBtnPressed(_ sender: CustomButton) {
    }
    
}

//MARK:- Private Methods
extension LoginVC {
    private func setupNavigation() {
        self.setupNavController(title: L10n.loginNav)
        self.setupNavigationItems(backAction: .popUpCurrent)
    }
}

//MARK:- LoginVC Protocol
extension LoginVC: AuthProtocol {
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
    
    func showAlert(title: String, message: String) {
        self.showSimpleAlert(title: title, message: message)
    }
    
}
