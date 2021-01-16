//
//  EditProfileView.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 09/01/2021.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit

class EditProfileView: UIView {
    // MARK:- IBOutlets
    @IBOutlet weak var nameTextField: IDEAHospitalTextField!
    @IBOutlet weak var emailTextField: IDEAHospitalTextField!
    @IBOutlet weak var mobileNoTextField: IDEAHospitalTextField!
    @IBOutlet weak var oldPasswordTextField: IDEAHospitalTextField!
    @IBOutlet weak var newPasswordTextField: IDEAHospitalTextField!
    @IBOutlet weak var confirmPasswordTextField: IDEAHospitalTextField!
    @IBOutlet weak var saveBtn: CustomButton!
    @IBOutlet weak var cancelBtn: CustomButton!
    
    // MARK:- Public Methods
    func setup() {
        setupBackground()
        setupTextFields()
        setupButtons()
    }
    
    func showData(with user: AuthData) {
        self.nameTextField.text = user.name
        self.emailTextField.text = user.email
        self.mobileNoTextField.text = user.mobile
    }
}

// MARK:- Private Methods
extension EditProfileView {
    private func setupTextFields() {
        nameTextField.setup(leftImage: Asset.name.image, placeholder: L10n.yourName)
        setupTextField(textField: nameTextField)
        emailTextField.setup(leftImage: Asset.email.image, placeholder: L10n.yourEmail)
        setupTextField(textField: emailTextField, keyboardType: .emailAddress)
        mobileNoTextField.setup(leftImage: Asset.phone.image, placeholder: L10n.mobileNumber)
        setupTextField(textField: mobileNoTextField, keyboardType: .asciiCapableNumberPad)
        oldPasswordTextField.setup(leftImage: Asset.password.image, placeholder: L10n.stars)
        setupTextField(textField: oldPasswordTextField, isSecured: true)
        newPasswordTextField.setup(leftImage: Asset.password.image, placeholder: L10n.setNewPassword)
        setupTextField(textField: newPasswordTextField, isSecured: true)
        confirmPasswordTextField.setup(leftImage: Asset.password.image, placeholder: L10n.confirmPassword)
        setupTextField(textField: confirmPasswordTextField, isSecured: true)
    }
    
    private func setupTextField(textField: UITextField, keyboardType: UIKeyboardType = .default, isSecured: Bool = false) {
        textField.keyboardType = keyboardType
        textField.isSecureTextEntry = isSecured
    }
    
    private func setupButtons() {
        cancelBtn.setBackgroundColor(color: ColorName.richPurpleTwo.color, forState: .normal)
        cancelBtn.setTitle(L10n.cancel, for: .normal)
        saveBtn.setTitle(L10n.save, for: .normal)
    }
}
