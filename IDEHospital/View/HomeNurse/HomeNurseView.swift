//
//  HomeNurseView.swift
//  IDEHospital
//
//  Created by Ziad on 12/16/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class HomeNurseView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var nameTextField: CommonTextField!
    @IBOutlet weak var emailTextField: CommonTextField!
    @IBOutlet weak var phoneTextField: CommonTextField!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var sendRequestButton: UIButton!
    
    // MARK:- Public Methods
    func setup() {
        setupBackground()
        setupInfoLabel()
        setupTextFields()
        setupDetailsTextView()
        setupButton()
    }
}

// MARK:- Private Methods
extension HomeNurseView {
    private func setupInfoLabel() {
        infoLabel.text = L10n.info
        infoLabel.font = FontFamily.PTSans.regular.font(size: 12)
        infoLabel.textAlignment = .center
        infoLabel.textColor = ColorName.white.color
        infoLabel.numberOfLines = 2
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
    
    private func setupButton() {
        sendRequestButton.setAttributedTitle(NSAttributedString(string: L10n.sendRequest, attributes: [NSAttributedString.Key.font: FontFamily.PTSans.bold.font(size: 20), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        sendRequestButton.backgroundColor = ColorName.darkRoyalBlue.color
        sendRequestButton.setupCornerRadiuss()
    }
}
