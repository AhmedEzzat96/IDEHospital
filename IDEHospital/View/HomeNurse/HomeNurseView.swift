//
//  HomeNurseView.swift
//  IDEHospital
//
//  Created by Ziad on 12/16/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class HomeNurseView: UIView {

    @IBOutlet weak var infoLabel: UILabel!
    
    func setup() {
        setupBackground()
        infoLabel.text = "If you would like further information about how we can help you and your health it would be great to hear from you"
        infoLabel.font = UIFont(font: FontFamily.PTSans.regular, size: 12)
        infoLabel.textAlignment = .center
        infoLabel.textColor = ColorName.white.color
        infoLabel.numberOfLines = 2
        infoLabel.adjustsFontSizeToFitWidth = true
    }

}
