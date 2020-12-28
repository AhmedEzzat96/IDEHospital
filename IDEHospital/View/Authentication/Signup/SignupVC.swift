//
//  SignupVC.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 27/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

protocol AuthProtocol: class {
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?)
    func showLoader()
    func hideLoader()
    func goToHomeScreen()
}

class SignupVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var signupView: SignupView!
    
    //MARK:- Properties
    private var viewModel: SignupViewModelProtocol!
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        signupView.setup()
        setupNavigation()
        self.viewModel = SignupViewModel(view: self)
    }
    
    //MARK:- Public Methods
    class func create() -> SignupVC {
        let signupVC: SignupVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signupVC)
        signupVC.viewModel = SignupViewModel(view: signupVC)
        return signupVC
    }
    
    //MARK:- IBActions
    @IBAction func signupBtnPressed(_ sender: CustomButton) {
        let user = User(name: signupView.nameTextField.text, email: signupView.emailTextField.text!, mobile: signupView.mobileNoTextField.text, password: signupView.passwordTextField.text!)
        viewModel.goToHome(user: user, confirmPassword: signupView.confirmPasswordTextField.text)
    }
    
    @IBAction func termsBtnPressed(_ sender: UIButton) {
    }
    
}

//MARK:- Private Methods
extension SignupVC {
    private func setupNavigation() {
        self.setupNavController(title: L10n.signupNav)
        self.setupNavigationItems(backAction: .popUpCurrent, isSettingEnable: false)
    }
}

//MARK:- Auth Protocol
extension SignupVC: AuthProtocol {
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
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
