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
    @IBOutlet weak var loginView: LoginView!
    
    //MARK:- Properties
    private var viewModel: LoginViewModelProtocol!
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.setup()
        setupNavigation()
    }
    
    //MARK:- Public Methods
    class func create() -> LoginVC {
        let loginVC: LoginVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.loginVC)
        loginVC.viewModel = LoginViewModel(view: loginVC)
        return loginVC
    }
    
    //MARK:- IBActions
    @IBAction func loginBtnPressed(_ sender: CustomButton) {
        let user = User(email: loginView.emailTextField.text, password: loginView.passwordTextField.text)
        viewModel.goToHome(user: user)
    }
    
    @IBAction func forgetPasswordBtnPressed(_ sender: UIButton) {
        goToResetPasswordVC()
    }
    
    @IBAction func signupBtnPressed(_ sender: CustomButton) {
        goToSignUpVC()
    }
    
}

//MARK:- Private Methods
extension LoginVC {
    private func setupNavigation() {
        self.setupNavController(title: L10n.loginNav)
        self.setupNavigationItems(backAction: .popUpCurrent, isSettingEnable: false)
    }
    
    private func goToSignUpVC() {
        let signupVC = SignupVC.create()
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    private func goToResetPasswordVC() {
        let resetPasswordVC = ResetPasswordVC.create()
        navigationController?.pushViewController(resetPasswordVC, animated: true)
    }
}

//MARK:- Auth Protocol
extension LoginVC: AuthProtocol {
    func showAlert(type: PopUpType, switchToHome: Bool = false) {
        showSimpleAlert(type: type, switchToHome)
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
