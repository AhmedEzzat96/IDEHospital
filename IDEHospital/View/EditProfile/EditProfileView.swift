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
}

// MARK:- Private Methods
extension EditProfileView {
    private func setupTextFields() {
        nameTextField.setup(leftImage: Asset.name.image, placeholder: L10n.yourName)
        emailTextField.setup(leftImage: Asset.email.image, placeholder: L10n.yourEmail)
        mobileNoTextField.setup(leftImage: Asset.phone.image, placeholder: L10n.mobileNumber)
        oldPasswordTextField.setup(leftImage: Asset.password.image, placeholder: "********")
        newPasswordTextField.setup(leftImage: Asset.password.image, placeholder: L10n.setNewPassword)
        confirmPasswordTextField.setup(leftImage: Asset.password.image, placeholder: L10n.confirmPassword)
    }
    
    private func setupButtons() {
        cancelBtn.setBackgroundColor(color: ColorName.richPurpleTwo.color, forState: .normal)
        cancelBtn.setTitle("Cancel", for: .normal)
        saveBtn.setTitle("Save", for: .normal)
    }
}
