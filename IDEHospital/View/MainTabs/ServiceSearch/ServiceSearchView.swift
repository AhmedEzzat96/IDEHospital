//
//  ServiceSearchView.swift
//  IDEHospital
//
//  Created by Ziad on 12/8/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class ServiceSearchView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var specialistsTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var regionTextField: UITextField!
    @IBOutlet weak var companiesTextField: UITextField!
    @IBOutlet weak var doctorNameTextField: UITextField!
    @IBOutlet weak var findDoctorButton: UIButton!
    
    @IBOutlet weak var toolBar: UIToolbar!
    // MARK:- Public Methods
    func setup() {
        setupBackground()
        setupLabels()
        setupTextFields()
        setupButton()
    }
}

// MARK:- Private Methods
extension ServiceSearchView {
    private func setupLabels() {
        setupLabel(firstTitleLabel, with: "IDEA EG HOSPITAL", fontSize: 38)
        setupLabel(secondTitleLabel, with: "IDEA EG HOSPITAL THE BEST CHOICE", fontSize: 19.5)
    }
    
    private func setupLabel(_ label: UILabel, with text: String, fontSize: CGFloat) {
        label.text = text
        label.textColor = .white
        label.textAlignment = .left
        label.font = firstTitleLabel.font.withSize(fontSize)
    }
    
    private func setupTextFields() {
        setupTextField(specialistsTextField, tag: 1, placeholder: "Choose Specialist", leftIcon: "group1")
        setupTextField(cityTextField, tag: 2, placeholder: "Choose City", leftIcon: "pin")
        setupTextField(regionTextField, tag: 3, placeholder: "Choose Region", leftIcon: "pin")
        setupTextField(companiesTextField, tag: 4, placeholder: "Choose Company", leftIcon: "life")
        setupTextField(doctorNameTextField, tag: 5, placeholder: "Doctor Name", leftIcon: "doctor")
    }
    
    private func setupTextField(_ textField: UITextField, tag: Int, placeholder: String, leftIcon: String) {
        textField.backgroundColor = .white
        textField.alpha = 0.8
        textField.tag = tag
        textField.font = UIFont(name: "Geeza Pro", size: 18)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes:[NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Geeza Pro", size: 16)!])
        textField.setTextFieldIcons(with: leftIcon)
        textField.setupCornerRadiuss()
    }
    
    private func setupButton() {
        findDoctorButton.setAttributedTitle(NSAttributedString(string: "Find a doctor", attributes: [NSAttributedString.Key.font: UIFont(name: "Geeza Pro", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        findDoctorButton.backgroundColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        findDoctorButton.setupCornerRadiuss()
    }
}
