//
//  UnAuthenticatedPopUpView.swift
//  IDEHospital
//
//  Created by Ziad on 1/10/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit

class UnAuthenticatedPopUpView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var authAndBookButton: CustomButton!
    @IBOutlet weak var termsButton: UIButton!
    
    // login
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginEmailTextField: IDEAHospitalTextField!
    @IBOutlet weak var loginPasswordTextField: IDEAHospitalTextField!
    @IBOutlet weak var loginHaveVoucherButton: UIButton!
    @IBOutlet weak var loginVoucherLabel: UILabel!
    @IBOutlet weak var loginVoucherTextField: UITextField!
    @IBOutlet weak var loginBookForAnotherButton: UIButton!
    @IBOutlet weak var loginBookForAnotherLabel: UILabel!
    @IBOutlet weak var loginPatientNameTextField: UITextField!

    // register
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var registerNameTextField: IDEAHospitalTextField!
    @IBOutlet weak var registerEmailTextField: IDEAHospitalTextField!
    @IBOutlet weak var registerPhoneTextField: IDEAHospitalTextField!
    @IBOutlet weak var registerPasswordTextField: IDEAHospitalTextField!
    @IBOutlet weak var registerHaveVoucherButton: UIButton!
    @IBOutlet weak var registerVoucherLabel: UILabel!
    @IBOutlet weak var registerVoucherTextField: UITextField!
    @IBOutlet weak var registerBookForAnotherButton: UIButton!
    @IBOutlet weak var registerBookForAnotherLabel: UILabel!
    @IBOutlet weak var registerPatientNameTextField: UITextField!
    
    // MARK:- Public Methods
    func setup() {
        setupContainerBackgroundAndRadius()
        setupGeneralButtons()
        setupLoginView()
        setupRegisterView()
    }
    
    func switchDisplayedView(toLogin: Bool, toRegister: Bool, authAndBookButtonTitle: String) {
        loginView.isHidden = !toLogin
        loginButton.isSelected = toLogin
        registerView.isHidden = !toRegister
        registerButton.isSelected = toRegister
        setupCancelButton(isSelected: toRegister)
        setupAuthAndBookButton(title: authAndBookButtonTitle)
        termsButton.isHidden = toLogin
        self.endEditing(true)
    }
    
    func handleCheckMarkButtonAndTextField(_ button: UIButton, _ textField: UITextField) {
        button.isSelected = !button.isSelected
        textField.isEnabled = !textField.isEnabled
        textField.text = nil
    }
}

// MARK:- Private Methods
extension UnAuthenticatedPopUpView {
    private func setupLoginView() {
        setupLoginViewTextFields()
        setupLoginViewCheckMarkButtons()
        setupLoginViewLabels()
    }
    
    private func setupRegisterView() {
        setupRegisterViewTextFields()
        setupRegisterViewCheckMarkButtons()
        setupRegisterViewLabels()
    }
    
    private func setupContainerBackgroundAndRadius() {
        let containerView = self.subviews.first!
        containerView.backgroundColor = .clear
        containerView.setupBackground(image: Asset.authPopUpBackground.image)
        containerView.setupCornerRadiuss(self.frame.height / 27, boundsClipped: true)
    }
    
    private func setupGeneralButtons() {
        setupTopButtons()
        setupAuthAndBookButton()
        setupTermsButton()
    }
    
    private func setupTopButtons() {
        setupTopButton(registerButton, selectionImage: Asset.registerViewSelected.image, title: L10n.register)
        setupTopButton(loginButton, selectionImage: Asset.loginViewSelected.image, title: L10n.login)
    }
    
    private func setupTopButton(_ button: UIButton, selectionImage: UIImage, title: String) {
        button.setAttributedTitle(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: FontFamily.PTSans.bold.font(size: 20), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        button.setAttributedTitle(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: FontFamily.PTSans.bold.font(size: 20), NSAttributedString.Key.foregroundColor: ColorName.darkRoyalBlue.color]), for: .selected)
        button.setBackgroundImage(selectionImage, for: .selected)
        button.setBackgroundImage(UIImage(), for: .normal)
    }
    
    private func setupCancelButton(isSelected: Bool) {
        cancelButton.setBackgroundImage(Asset.cancelBlue.image, for: .normal)
        cancelButton.setBackgroundImage(Asset.cancelWhite.image, for: .selected)
        cancelButton.isSelected = isSelected
    }
    
    private func setupRegisterViewCheckMarkButtons() {
        setupCheckMarkButton(registerHaveVoucherButton)
        setupCheckMarkButton(registerBookForAnotherButton)
    }
    
    private func setupLoginViewCheckMarkButtons() {
        setupCheckMarkButton(loginHaveVoucherButton)
        setupCheckMarkButton(loginBookForAnotherButton)
    }
    
    private func setupCheckMarkButton(_ button: UIButton) {
        button.setImage(Asset.emptyCheckMark.image, for: .normal)
        button.setImage(Asset.filledCheckMark.image, for: .selected)
        button.tintColor = .white
    }
    
    private func setupAuthAndBookButton(title: String = L10n.signUpAndBook) {
        authAndBookButton.setAttributedTitle(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: FontFamily.PTSans.bold.font(size: 17)]), for: .normal)
    }
    
    private func setupTermsButton() {
        let attributedString = NSMutableAttributedString(string: L10n.acceptTerms, attributes: [
            .font: FontFamily.PTSans.regular.font(size: 12),
          .foregroundColor: UIColor.white
        ])
        termsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        attributedString.addAttribute(.font, value: FontFamily.PTSans.bold.font(size: 12), range: NSRange(location: 38, length: 18))
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 38, length: 18))
        termsButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    private func setupRegisterViewTextFields() {
        registerNameTextField.setup(leftImage: Asset.name.image, placeholder: L10n.yourName)
        registerEmailTextField.setup(leftImage: Asset.email.image, placeholder: L10n.yourEmail)
        registerPhoneTextField.setup(leftImage: Asset.phone.image, placeholder: L10n.mobileNumber)
        registerPasswordTextField.setup(leftImage: Asset.password.image, placeholder: L10n.choosePassword)
        setupOptionadlTextField(registerVoucherTextField, placeholder: L10n.enterCode)
        setupOptionadlTextField(registerPatientNameTextField, placeholder: L10n.enterName)
    }
    
    private func setupLoginViewTextFields() {
        loginEmailTextField.setup(leftImage: Asset.email.image, placeholder: L10n.yourEmail)
        loginPasswordTextField.setup(leftImage: Asset.password.image, placeholder: L10n.yourPassword)
        setupOptionadlTextField(loginVoucherTextField, placeholder: L10n.enterCode)
        setupOptionadlTextField(loginPatientNameTextField, placeholder: L10n.enterName)
    }
    
    private func setupRegisterViewLabels() {
        setupLabel(registerVoucherLabel, text: L10n.haveVoucherCode)
        setupLabel(registerBookForAnotherLabel, text: L10n.bookForAnother)
    }
    
    private func setupLoginViewLabels() {
        setupLabel(loginVoucherLabel, text: L10n.haveVoucherCode)
        setupLabel(loginBookForAnotherLabel, text: L10n.bookForAnother)
    }
    
    private func setupLabel(_ label: UILabel, text: String) {
        label.text = text
        label.textColor = ColorName.white.color
        label.font = FontFamily.PTSans.bold.font(size: 12)
    }
    
    
    private func setupOptionadlTextField(_ textField: UITextField, placeholder: String) {
        textField.isEnabled = false
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.font = FontFamily.PTSans.bold.font(size: 12)
        textField.textColor = ColorName.white.color
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: ColorName.white.color])
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.size.height, width: textField.frame.size.width, height: 1)
        bottomLine.backgroundColor = ColorName.white.color.cgColor
        textField.layer.addSublayer(bottomLine)
    }
}
