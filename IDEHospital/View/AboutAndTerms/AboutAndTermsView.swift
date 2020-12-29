//
//  AboutView.swift
//  IDEHospital
//
//  Created by Ziad on 12/28/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class AboutAndTermsView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var aboutOrTermsLabel: UILabel!
    
    // MARK:- Public Methods
    func setup() {
        setupBackground()
        setupLabel()
    }
}

// MARK:- Private Methods
extension AboutAndTermsView {
    private func setupLabel() {
        aboutOrTermsLabel.numberOfLines = 0
        aboutOrTermsLabel.textColor = ColorName.white.color
        aboutOrTermsLabel.font = FontFamily.PTSans.regular.font(size: 12)
        aboutOrTermsLabel.text = ""
        aboutOrTermsLabel.layoutIfNeeded()
    }
}
