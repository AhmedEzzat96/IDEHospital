//
//  UIView+SetupBackground.swift
//  IDEHospital
//
//  Created by Ziad on 12/9/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

extension UIView {
    func setupBackground(image: UIImage = Asset.background.image) {
        let background = UIImageView(image: image)
        background.frame = UIScreen.main.bounds
        background.contentMode =  .scaleAspectFill
        self.insertSubview(background, at: 0)
    }
}
