//
//  SignupView.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 27/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class SignupView: UIView {
    //MARK:- IBOutlets
    @IBOutlet weak var nameTextField: IDEAHospitalTextField!
    @IBOutlet weak var emailTextField: IDEAHospitalTextField!
    @IBOutlet weak var mobileNoTextField: IDEAHospitalTextField!
    @IBOutlet weak var passwordTextField: IDEAHospitalTextField!
    @IBOutlet weak var signupBtn: CustomButton!
    @IBOutlet weak var confirmPasswordTextField: IDEAHospitalTextField!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var termsBtn: UIButton!
    
    //MARK:- Public Methods
    func setup() {
        setupBackground()
        setupTextFields()
        setupCustomButton()
        setupLabel()
        setupButton()
    }
}

//MARK:- Private Methods
extension SignupView {
    private func setupTextFields() {
        nameTextField.setup(leftImage: Asset.name.image, placeholder: L10n.yourName)
        emailTextField.keyboardType = .emailAddress
        emailTextField.setup(leftImage: Asset.email.image, placeholder: L10n.yourEmail)
        mobileNoTextField.keyboardType = .numberPad
        mobileNoTextField.setup(leftImage: Asset.phone.image, placeholder: L10n.mobileNumber)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.setup(leftImage: Asset.password.image, placeholder: L10n.choosePassword)
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.setup(leftImage: Asset.password.image, placeholder: L10n.confirmPassword)
    }
    
    private func setupCustomButton() {
        signupBtn.setTitle(L10n.signup, for: .normal)
        signupBtn.titleLabel?.font = FontFamily.PTSans.bold.font(size: 20)
    }
    
    private func setupLabel() {
        termsLabel.text = L10n.termsLabel
        termsLabel.font = FontFamily.PTSans.regular.font(size: 12)
        termsLabel.textColor = .white
    }
    
    private func setupButton() {
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: FontFamily.PTSans.bold.font(size: 12),
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: L10n.termsBtn,
                                                        attributes: yourAttributes)
        termsBtn.setAttributedTitle(attributeString, for: .normal)
    }
}
