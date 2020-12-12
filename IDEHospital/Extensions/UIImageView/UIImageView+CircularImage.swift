//
//  UIImageView+CircularImageBorder.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 07/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

extension UIImageView {
    func circularImageView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}
