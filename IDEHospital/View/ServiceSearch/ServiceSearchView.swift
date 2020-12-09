//
//  ServiceSearchView.swift
//  IDEHospital
//
//  Created by Ziad on 12/8/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class ServiceSearchView: UIView {

    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    
    func setupLabels() {
        firstTitleLabel.text = "IDEA EG HOSPITAL"
        firstTitleLabel.textColor = .white
        firstTitleLabel.textAlignment = .left
        firstTitleLabel.font = firstTitleLabel.font.withSize(38)
        
        secondTitleLabel.text = "IDEA EG HOSPITAL THE BEST CHOICE"
        secondTitleLabel.textColor = .white
        secondTitleLabel.textAlignment = .left
        secondTitleLabel.font = secondTitleLabel.font.withSize(19.5)
    }
}
