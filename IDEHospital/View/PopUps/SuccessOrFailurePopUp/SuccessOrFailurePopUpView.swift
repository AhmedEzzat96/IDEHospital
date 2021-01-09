//
//  SuccessOrFailurePopUpView.swift
//  IDEHospital
//
//  Created by Ziad on 1/5/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit

class SuccessOrFailurePopUpView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var popUpImage: UIImageView!
    @IBOutlet weak var popUpLabel: UILabel!
    @IBOutlet weak var okButton: CustomButton!
    
    
    // MARK:- Public Methods
    func setup(_ image: String, title: String) {
        setupContainerRadius()
        setupPopUpImage(image)
        setupPopUpLabel(title)
        setupOkButton()
    }
}

// MARK:- Private Methods
extension SuccessOrFailurePopUpView {
    private func setupContainerRadius() {
        let containerView = self.subviews.first!
            containerView.setupCornerRadiuss(10)
    }
    
    private func setupPopUpImage(_ Image: String) {
        popUpImage.image = UIImage(named: Image)
    }
    
    private func setupPopUpLabel(_ text: String) {
        popUpLabel.text = text
        popUpLabel.textAlignment = .center
        popUpLabel.textColor = ColorName.darkRoyalBlue.color
        popUpLabel.font = FontFamily.PTSans.bold.font(size: 15)
    }
    
    private func setupOkButton() {
        okButton.setTitle(L10n.ok, for: .normal)
        okButton.titleLabel?.font = FontFamily.PTSans.regular.font(size: 15)
    }
}
