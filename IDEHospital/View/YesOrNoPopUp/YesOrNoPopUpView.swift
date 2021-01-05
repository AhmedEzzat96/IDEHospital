//
//  YesOrNoPopUpView.swift
//  IDEHospital
//
//  Created by Ziad on 1/5/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit

class YesOrNoPopUpView: UIView {
    
    // MARK:- Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yesButton: CustomButton!
    @IBOutlet weak var noButton: CustomButton!
    
    // MARK:- Public Methods
    func setup(title: String) {
        setupContainerRadius()
        setupTitleLabel(title)
        setupButtons()
    }
}

// MARK:- Private Methods
extension YesOrNoPopUpView {
    private func setupContainerRadius() {
        let containerView = self.subviews.first!
            containerView.setupCornerRadiuss(10)
    }
    
    func setupTitleLabel(_ text: String) {
        titleLabel.text = text
        titleLabel.textColor = ColorName.darkRoyalBlue.color
        titleLabel.font = FontFamily.PTSans.bold.font(size: 15)
    }
    
    private func setupButtons() {
        setupButton(yesButton, title: L10n.yes)
        setupButton(noButton, title: L10n.no, color: ColorName.richPurpleTwo.color)
    }
    
    private func setupButton(_ button: CustomButton, title: String, color: UIColor = ColorName.darkRoyalBlue.color) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = FontFamily.PTSans.regular.font(size: 15)
        button.backgroundColor = color
    }
}
