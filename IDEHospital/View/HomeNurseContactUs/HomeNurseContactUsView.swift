//
//  HomeNurseView.swift
//  IDEHospital
//
//  Created by Ziad on 12/16/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class HomeNurseContactUsView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameTextField: IDEAHospitalTextField!
    @IBOutlet weak var emailTextField: IDEAHospitalTextField!
    @IBOutlet weak var phoneTextField: IDEAHospitalTextField!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var sendRequestButton: CustomButton!
    
    // MARK:- Public Methods
    func setup(buttonTitle: String, isNumberLabelHidden: Bool) {
        setupBackground()
        setupLabels(isNumberLabelHidden)
        setupTextFields()
        setupDetailsTextView()
        setupButton(title: buttonTitle)
    }
}

// MARK:- Private Methods
extension HomeNurseContactUsView {
    private func setupLabels(_ isNumberLabelHidden: Bool) {
        setupInfoLabel()
        setupNumberLabel(isNumberLabelHidden)
    }
    
    private func setupInfoLabel() {
        infoLabel.text = L10n.info
        infoLabel.font = FontFamily.PTSans.regular.font(size: 12)
        infoLabel.textAlignment = .center
        infoLabel.textColor = ColorName.white.color
        infoLabel.numberOfLines = 2
    }
    
    private func setupNumberLabel(_ isHidden: Bool) {
        numberLabel.isHidden = isHidden
        numberLabel.text = L10n.number
        numberLabel.font = FontFamily.PTSans.regular.font(size: 12)
        numberLabel.textAlignment = .center
        numberLabel.textColor = ColorName.white.color
    }
    
    private func setupTextFields() {
        nameTextField.setup(leftImage: Asset.name.image, placeholder: L10n.yourName)
        emailTextField.setup(leftImage: Asset.email.image, placeholder: L10n.yourEmail)
        emailTextField.keyboardType = .emailAddress
        phoneTextField.setup(leftImage: Asset.phone.image, placeholder: L10n.mobileNumber)
        phoneTextField.keyboardType = .phonePad
    }
    
    private func setupDetailsTextView() {
        detailsTextView.attributedText = NSAttributedString(string: L10n.enterDetails, attributes: [NSAttributedString.Key.foregroundColor: ColorName.white.color, NSAttributedString.Key.font: FontFamily.PTSans.bold.font(size: 15)])
        infoLabel.adjustsFontSizeToFitWidth = true
        detailsTextView.backgroundColor = .clear
        detailsTextView.layer.borderWidth = 1
        detailsTextView.layer.borderColor = ColorName.white.color.cgColor
        detailsTextView.layer.cornerRadius = 10
    }
    
    private func setupButton(title: String) {
        sendRequestButton.setTitle(title, for: .normal)
        sendRequestButton.titleLabel?.font = FontFamily.PTSans.bold.font(size: 20)
    }
}
