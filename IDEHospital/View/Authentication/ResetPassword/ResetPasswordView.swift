//
//  ResetPasswordView.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 26/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class ResetPasswordView: UIView {
    //MARK:- IBOutlets
    @IBOutlet weak var emailTextField: IDEAHospitalTextField!
    @IBOutlet weak var setNewPasswordBtn: CustomButton!

    //MARK:- Public Methods
    func setup() {
        self.setupBackground()
        setupTextFields()
        setupButtons()
    }
}

//MARK:- Private Methods
extension ResetPasswordView {
    private func setupTextFields() {
        emailTextField.keyboardType = .emailAddress
        emailTextField.setup(leftImage: Asset.email.image, placeholder: L10n.yourEmail)
    }
    
    private func setupButtons() {
        setNewPasswordBtn.setTitle(L10n.setNewPassword, for: .normal)
        setNewPasswordBtn.titleLabel?.font = FontFamily.PTSans.bold.font(size: 20)
    }
}
