//
//  UIView+CornerRadius.swift
//  IDEHospital
//
//  Created by Ziad on 12/9/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

extension UIView {
    func setupCornerRadiuss() {
        self.layer.cornerRadius = self.frame.size.height/3.5
        self.clipsToBounds = true
    }
}
