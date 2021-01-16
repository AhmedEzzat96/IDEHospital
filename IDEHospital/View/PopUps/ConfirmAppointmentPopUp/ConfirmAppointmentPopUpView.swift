//
//  ConfirmAppointmentPopUpView.swift
//  IDEHospital
//
//  Created by Ziad on 1/5/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit

class ConfirmAppointmentPopUpView: UIView {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmAppointmentLabel: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var confirmButton: CustomButton!
    
    // MARK:- Public Methods
    func setup(_ dateAndTime: String, _ doctorName: String) {
        setupContainerRadius()
        setupLabels(dateAndTime, doctorName)
        setupButtons()
    }

}

// MARK:- Private Methods
extension ConfirmAppointmentPopUpView {
    private func setupContainerRadius() {
        let containerView = self.subviews.first!
            containerView.setupCornerRadiuss(10)
    }
    
    private func setupLabels(_ dateAndTime: String,_ doctorName: String) {
        setupConfirmAppointmentLabel()
        setupDateAndTimeLabel(dateAndTime, doctorName)
    }
    
    private func setupConfirmAppointmentLabel() {
        confirmAppointmentLabel.text = L10n.confirmAppointment
        confirmAppointmentLabel.textColor = ColorName.darkRoyalBlue.color
        confirmAppointmentLabel.font = FontFamily.PTSans.bold.font(size: 15)
    }
    
    private func setupDateAndTimeLabel(_ dateAndTime: String, _ doctorName: String) {
        let attributedString = NSMutableAttributedString(string: "You are about to book an appointment on \(dateAndTime) with Doctor \(doctorName)", attributes: [
            .font: FontFamily.PTSans.regular.font(size: 15),
            .foregroundColor: ColorName.black.color
        ])
        attributedString.addAttribute(.font, value: FontFamily.PTSans.bold.font(size: 15), range: NSRange(location: 40, length: dateAndTime.count))
        attributedString.addAttribute(.font, value: FontFamily.PTSans.bold.font(size: 15), range: NSRange(location: 46 + dateAndTime.count, length: 7 + doctorName.count))
        dateAndTimeLabel.attributedText = attributedString
        dateAndTimeLabel.numberOfLines = 0
        dateAndTimeLabel.sizeToFit()
        dateAndTimeLabel.textAlignment = .center
    }
    
    private func setupButtons() {
        setupCancelButton()
        setupConfirmButton()
    }
    
    private func setupCancelButton() {
        cancelButton.setBackgroundImage(Asset.cancelBlue.image, for: .normal)
    }
    
    private func setupConfirmButton() {
        confirmButton.titleLabel?.font = FontFamily.PTSans.bold.font(size: 15)
        confirmButton.setTitle(L10n.confirm, for: .normal)
    }
}
