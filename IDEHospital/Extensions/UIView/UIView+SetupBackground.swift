//
//  UIView+SetupBackground.swift
//  IDEHospital
//
//  Created by Ziad on 12/9/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

extension UIView {
    func setupBackground() {
        let background = UIImageView(image: Asset.background.image)
        background.frame = self.bounds
        addSubview(background)
        self.sendSubviewToBack(background)
    }
}
