//
//  UIViewController+NavControllerSetup.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 11/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func setupNavController(title: String) {
        self.navigationItem.title = title
        self.navigationController?.navigationBar.clipsToBounds = true
        navigationController?.navigationBar.barTintColor = ColorName.veryLightPink.color
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : ColorName.white.color,
            NSAttributedString.Key.font: FontFamily.PTSans.bold.font(size: 20) as Any
        ]
    }
}

