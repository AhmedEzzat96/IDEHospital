//
//  LoginView.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 27/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class LoginView: UIView {
    //MARK:- IBOutlets
    @IBOutlet weak var emailTextField: IDEAHospitalTextField!
    @IBOutlet weak var passwordTextField: IDEAHospitalTextField!
    @IBOutlet weak var loginBtn: CustomButton!
    @IBOutlet weak var forgetPasswordBtn: UIButton!
    @IBOutlet weak var signupBtn: CustomButton!
    @IBOutlet weak var dontHaveAccLabel: UILabel!
    
    //MARK:- Public Methods
    func setup() {
        setupBackground()
        setupTextFields()
        setupCustomButtons(button: loginBtn, title: L10n.login)
        setupCustomButtons(button: signupBtn, title: L10n.signup, backgroundColor: ColorName.steelGrey.color)
        setupButton()
        setupLabel()
    }

}

//MARK:- Private Methods
extension LoginView {
    private func setupTextFields() {
        emailTextField.setup(leftImage: Asset.email.image, placeholder: L10n.yourEmail)
        passwordTextField.setup(leftImage: Asset.password.image, placeholder: L10n.yourPassword)
    }
    
    private func setupCustomButtons(button: CustomButton, title: String, backgroundColor: UIColor = ColorName.darkRoyalBlue.color) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = FontFamily.PTSans.bold.font(size: 20)
        button.backgroundColor = backgroundColor
    }
    
    private func setupButton() {
        forgetPasswordBtn.setTitle(L10n.forgotPassword, for: .normal)
        forgetPasswordBtn.setTitleColor(.white, for: .normal)
        forgetPasswordBtn.titleLabel?.font = FontFamily.PTSans.bold.font(size: 15)
    }
    
    private func setupLabel() {
        dontHaveAccLabel.text = L10n.donTHaveAccount
        dontHaveAccLabel.font = FontFamily.PTSans.regular.font(size: 12)
        dontHaveAccLabel.textColor = .white
    }
}
