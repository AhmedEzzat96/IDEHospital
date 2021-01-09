//
//  VoucherPopUpView.swift
//  IDEHospital
//
//  Created by Ziad on 1/5/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit

class VoucherPopUpView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var voucherLabel: UILabel!
    @IBOutlet weak var voucherSwitch: UISwitch!
    @IBOutlet weak var voucherYesLabel: UILabel!
    @IBOutlet weak var voucherNoLabel: UILabel!
    @IBOutlet weak var voucherCodeTextField: UITextField!
    
    @IBOutlet weak var anotherPersonLabel: UILabel!
    @IBOutlet weak var anotherPersonSwitch: UISwitch!
    @IBOutlet weak var anotherPersonYesLabel: UILabel!
    @IBOutlet weak var anotherPersonNoLabel: UILabel!
    @IBOutlet weak var anotherPersonNameTextField: UITextField!
    
    @IBOutlet weak var continueButton: CustomButton!
    
    // MARK:- Public Methods
    func setup() {
        setupContainerRadius()
        setupLabels()
        setupSwitches()
        setupTextFields()
        setupContinueButton()
    }
}

// MARK:- Private Methods
extension VoucherPopUpView {
    private func setupContainerRadius() {
        let containerView = self.subviews.first!
            containerView.setupCornerRadiuss(10)
    }
    
    private func setupLabels() {
        setUpLabel(voucherLabel, text: L10n.voucherTitle)
        setUpLabel(voucherYesLabel, text: L10n.yes)
        setUpLabel(voucherNoLabel, text: L10n.no)
        setUpLabel(anotherPersonLabel, text: L10n.bookingAnotherPerson)
        setUpLabel(anotherPersonYesLabel, text: L10n.yes)
        setUpLabel(anotherPersonNoLabel, text: L10n.no)
    }
    
    private func setUpLabel(_ label: UILabel, text: String) {
        label.text = text
        label.textColor = ColorName.darkRoyalBlue.color
        label.font = FontFamily.PTSans.bold.font(size: 15)
    }
    
    private func setupSwitches() {
        setupSwitch(voucherSwitch)
        setupSwitch(anotherPersonSwitch)
    }
    
    private func setupSwitch(_ switcher: UISwitch) {
        switcher.onTintColor = ColorName.darkRoyalBlue.color
        switcher.backgroundColor = ColorName.veryLightPink.color
        switcher.setupCornerRadiuss(switcher.frame.height/2)
    }
    
    private func setupTextFields() {
        setupTextField(voucherCodeTextField, placeholder: L10n.enterCode)
        setupTextField(anotherPersonNameTextField, placeholder: L10n.enterName)
    }
    
    private func setupTextField(_ textField: UITextField, placeholder: String) {
        textField.font = FontFamily.PTSans.regular.font(size: 15)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: ColorName.black.color])
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        textField.leftViewMode = .always
        textField.leftView = leftPadding
        textField.borderStyle = .none
        textField.setupCornerRadiuss()
        textField.layer.borderWidth = 1

    }
    
    private func setupContinueButton() {
        continueButton.titleLabel?.font = FontFamily.PTSans.regular.font(size: 15)
        continueButton.setTitle(L10n.continue, for: .normal)
    }
}
